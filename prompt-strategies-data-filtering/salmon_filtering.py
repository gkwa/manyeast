import re
import json
import typing
import abc
import sys
import argparse


class ProductFilter(abc.ABC):
    """Abstract base class for product filters"""

    @abc.abstractmethod
    def filter_products(
        self, products: typing.List[typing.Dict]
    ) -> typing.List[typing.Dict]:
        """Filter and score products"""
        pass


class RuleBasedSalmonFilter(ProductFilter):
    """Rule-based salmon product filter using keyword matching"""

    def __init__(self):
        # Keywords that indicate actual salmon products we want
        self.positive_keywords = [
            "salmon",
            "sockeye",
            "pacific",
            "alaska",
            "coho",
            "chinook",
            "keta",
        ]

        # Keywords that indicate products we definitely don't want
        self.negative_keywords = [
            "anchovies",
            "atlantic",
            "battered",
            "biscuit",
            "blackened",
            "color added",
            "sesame",
            "bourbon",
            "broccoli",
            "burger",
            "caesar salad",
            "caviar",
            "cedar plank",
            "char",
            "chicken",
            "cod",
            "cottage cheese",
            "crusted",
            "cubes",
            "farm",
            "farmed",
            "garlic herb",
            "grilled",
            "guacamole",
            "halibut",
            "honey chipotle",
            "juice",
            "mahi mahi",
            "marinated",
            "mocktail",
            "onion rings",
            "peaches",
            "plant based",
            "pollock",
            "previously frozen",
            "rub",
            "raised",
            "sablefish",
            "salad",
            "sardines",
            "seasoned",
            "seasoning",
            "shrimp",
            "smoke",
            "pacific cod",
            "smoked",
            "steak",
            "stuffed",
            "breaded",
            "sweet potatoes",
            "tilapia",
            "tortillas",
            "trout",
            "tuna",
            "vegan",
        ]

        # Keywords that indicate less desirable salmon products
        self.somewhat_negative_keywords = [
            "canned",
            "creations",
            "servings",
            "nuggets",
            "poke bowl",
            "pouch",
            "teriyaki",
        ]

        # Keywords that indicate frozen/fresh salmon fillets
        self.preferred_keywords = [
            "fillet",
            "fillets",
            "frozen",
            "fresh",
            "wild",
            "portion",
            "portions",
            "skinless",
            "boneless",
            "skin-on",
            "never frozen",
        ]

        # Ocean and region keywords for categorization
        self.ocean_keywords = {
            "atlantic": ["atlantic"],
            "pacific": ["pacific", "alaska", "alaskan"],
            "arctic": ["arctic"],
            "north_sea": ["north sea", "norwegian", "norway"],
            "other": ["canadian", "scottish", "faroese", "chilean", "tasmanian"],
        }

    def extract_price(self, text: str) -> typing.Optional[float]:
        """Extract price from product text"""
        price_patterns = [
            r"\$\s*(\d+\.\d{2})",  # $10.99
            r"\$\s*(\d+)\s*\.\s*(\d{2})",  # $10 . 99
            r"price:\s*\$\s*(\d+\.\d{2})",  # price: $10.99
            r"(\d+\.\d{2})\s*/\s*ea",  # 10.99 / ea
        ]

        for pattern in price_patterns:
            matches = re.findall(pattern, text, re.IGNORECASE)
            if matches:
                if isinstance(matches[0], tuple):
                    return float(f"{matches[0][0]}.{matches[0][1]}")
                else:
                    return float(matches[0])
        return None

    def extract_ocean_origin(
        self, product: typing.Dict
    ) -> typing.Tuple[typing.Optional[str], typing.List[str]]:
        """Extract ocean/region origin information"""
        name = product.get("Name", "").lower()
        text = product.get("CleanedText", "").lower()
        combined_text = f"{name} {text}"

        found_origins = []
        primary_origin = None

        for ocean_type, keywords in self.ocean_keywords.items():
            for keyword in keywords:
                if keyword in combined_text:
                    found_origins.append(keyword)
                    if primary_origin is None:
                        primary_origin = ocean_type

        return primary_origin, found_origins

    def calculate_relevance_score(
        self, product: typing.Dict
    ) -> typing.Tuple[float, str, typing.Dict]:
        """Calculate relevance score for a salmon product"""
        name = product.get("Name", "").lower()
        text = product.get("CleanedText", "").lower()
        combined_text = f"{name} {text}"

        score = 0
        reasons = []
        score_breakdown = {}

        # Find positive keywords
        positive_found = [kw for kw in self.positive_keywords if kw in combined_text]
        positive_score = len(positive_found) * 3
        score += positive_score
        score_breakdown["positive_keywords"] = {
            "score": positive_score,
            "keywords": positive_found,
        }
        if positive_found:
            reasons.append(f"Salmon keywords ({len(positive_found)}): {positive_found}")

        # Find negative keywords
        negative_found = [kw for kw in self.negative_keywords if kw in combined_text]
        negative_score = len(negative_found) * -10
        score += negative_score
        score_breakdown["negative_keywords"] = {
            "score": negative_score,
            "keywords": negative_found,
        }
        if negative_found:
            reasons.append(
                f"Unwanted keywords ({len(negative_found)}): {negative_found}"
            )

        # Find somewhat negative keywords
        somewhat_negative_found = [
            kw for kw in self.somewhat_negative_keywords if kw in combined_text
        ]
        somewhat_negative_score = len(somewhat_negative_found) * -2
        score += somewhat_negative_score
        score_breakdown["somewhat_negative_keywords"] = {
            "score": somewhat_negative_score,
            "keywords": somewhat_negative_found,
        }
        if somewhat_negative_found:
            reasons.append(
                f"Less desirable keywords ({len(somewhat_negative_found)}): {somewhat_negative_found}"
            )

        # Find preferred keywords
        preferred_found = [kw for kw in self.preferred_keywords if kw in combined_text]
        preferred_score = len(preferred_found) * 2
        score += preferred_score
        score_breakdown["preferred_keywords"] = {
            "score": preferred_score,
            "keywords": preferred_found,
        }
        if preferred_found:
            reasons.append(
                f"Preferred keywords ({len(preferred_found)}): {preferred_found}"
            )

        # Extract ocean origin
        ocean_origin, origin_keywords = self.extract_ocean_origin(product)
        score_breakdown["ocean_origin"] = {
            "primary_origin": ocean_origin,
            "found_keywords": origin_keywords,
        }
        if ocean_origin:
            reasons.append(f"Ocean origin: {ocean_origin} ({origin_keywords})")

        # Bonus if "salmon" is in the product name
        salmon_name_bonus = 0
        if "salmon" in name:
            salmon_name_bonus = 4
            score += salmon_name_bonus
            reasons.append("Salmon in product name")
        score_breakdown["salmon_in_name"] = {"score": salmon_name_bonus}

        # Extra bonus for "fillet" in name
        fillet_name_bonus = 0
        if "fillet" in name:
            fillet_name_bonus = 3
            score += fillet_name_bonus
            reasons.append("Fillet in product name")
        score_breakdown["fillet_in_name"] = {"score": fillet_name_bonus}

        return score, "; ".join(reasons), score_breakdown

    def calculate_price_per_oz(
        self, product: typing.Dict, price: typing.Optional[float]
    ) -> typing.Optional[float]:
        """Try to calculate price per ounce for comparison"""
        text = product.get("CleanedText", "").lower()
        name = product.get("Name", "").lower()
        combined = f"{name} {text}"

        # First, try to find direct price per ounce patterns
        price_per_oz_patterns = [
            r"\$\s*(\d+\.\d{2})/oz",  # $2.31/oz
            r"\$\s*(\d+\.\d{2})\s*/\s*oz",  # $2.31 / oz
            r"\(\$\s*(\d+\.\d{2})/ounce\)",  # ($0.41/ounce)
            r"\(\$\s*(\d+\.\d{2})\s*/\s*ounce\)",  # ($0.41 / ounce)
            r"(\d+\.\d{2})\s*/\s*oz",  # 2.31 / oz
            r"\$\s*(\d+\.\d{2})\s*/\s*oz",  # $ 2.31 / oz
        ]

        for pattern in price_per_oz_patterns:
            matches = re.findall(pattern, combined)
            if matches:
                return float(matches[0])

        # If no direct price per ounce found, try to find price per pound and convert
        price_per_lb_patterns = [
            r"\$(\d+\.\d{2})/lb",  # $17.99/lb
            r"\$(\d+\.\d{2})\s*/\s*lb",  # $17.99 / lb
            r"\$\s*(\d+\.\d{2})\s*/\s*lb",  # $ 17.99 / lb
            r"\$\s*(\d+)\s*\.\s*(\d{2})\s*/\s*lb",  # $ 17 . 99 /lb
            r"(\d+\.\d{2})\s*/\s*lb",  # 17.99/lb
            r"\$(\d+\.\d{2})\s*per\s*pound",  # $14.99 per pound
            r"price:\s*\$(\d+\.\d{2})\s*per\s*pound",  # price: $14.99 per pound
        ]

        for pattern in price_per_lb_patterns:
            matches = re.findall(pattern, combined)
            if matches:
                if isinstance(matches[0], tuple):
                    # Handle the case where we captured dollars and cents separately
                    price_per_lb = float(f"{matches[0][0]}.{matches[0][1]}")
                else:
                    price_per_lb = float(matches[0])
                # Convert price per pound to price per ounce (16 ounces in a pound)
                return round(price_per_lb / 16, 2)

        # If we still haven't found anything, try to calculate from base price and weight
        if not price:
            return None

        weight_patterns = [
            r"(\d+(?:\.\d+)?)\s*oz",
            r"(\d+(?:\.\d+)?)\s*ounce",
            r"(\d+(?:\.\d+)?)\s*lb",
            r"(\d+(?:\.\d+)?)\s*pound",
        ]

        for pattern in weight_patterns:
            matches = re.findall(pattern, combined)
            if matches:
                weight = float(matches[0])
                if "lb" in pattern or "pound" in pattern:
                    weight *= 16  # Convert pounds to ounces
                return round(price / weight, 2)

        return None

    def filter_products(
        self, products: typing.List[typing.Dict]
    ) -> typing.List[typing.Dict]:
        """Filter and rank products by relevance"""
        for product in products:
            score, reasoning, score_breakdown = self.calculate_relevance_score(product)
            price = self.extract_price(product.get("CleanedText", ""))
            price_per_oz = self.calculate_price_per_oz(product, price)
            ocean_origin, origin_keywords = self.extract_ocean_origin(product)

            # Initialize scoring object if it doesn't exist
            if "Scoring" not in product:
                product["Scoring"] = {}

            # Add rule-based scoring to nested object
            product["Scoring"]["rule_score"] = score
            product["Scoring"]["rule_reasoning"] = reasoning
            product["Scoring"]["rule_breakdown"] = score_breakdown
            product["Scoring"]["extracted_price"] = price
            product["Scoring"]["price_per_oz"] = price_per_oz
            product["Scoring"]["ocean_origin"] = ocean_origin
            product["Scoring"]["origin_keywords"] = origin_keywords

            # Also update the top-level PricePerOZ field
            product["PricePerOZ"] = price_per_oz

            # Add ocean origin to top level for easy access
            product["OceanOrigin"] = ocean_origin

        return products


class SemanticSalmonFilter(ProductFilter):
    """Semantic filtering using embeddings/similarity - placeholder for future implementation"""

    def __init__(self, target_embedding: typing.Optional[typing.Any] = None):
        self.target_embedding = target_embedding
        # In real implementation, you'd load a model like sentence-transformers
        # self.model = SentenceTransformer('all-MiniLM-L6-v2')
        # self.target_embedding = self.model.encode("fresh frozen salmon fillet")

    def calculate_semantic_similarity(
        self, product_text: str
    ) -> typing.Tuple[float, typing.Dict]:
        """Calculate semantic similarity score (placeholder)"""
        # Placeholder: In real implementation, you'd:
        # 1. Generate embedding for product text
        # 2. Calculate cosine similarity with target embedding
        # 3. Return similarity score

        # For now, just return a mock score based on simple text matching
        target_concepts = ["salmon", "fillet", "fresh", "frozen", "fish"]
        product_lower = product_text.lower()
        matches = [concept for concept in target_concepts if concept in product_lower]
        score = len(matches) / len(target_concepts)

        semantic_breakdown = {
            "target_concepts": target_concepts,
            "matched_concepts": matches,
            "similarity_score": score,
        }

        return score, semantic_breakdown

    def filter_products(
        self, products: typing.List[typing.Dict]
    ) -> typing.List[typing.Dict]:
        """Add semantic scores to products"""
        for product in products:
            name = product.get("Name", "")
            text = product.get("CleanedText", "")
            combined_text = f"{name} {text}"

            semantic_score, semantic_breakdown = self.calculate_semantic_similarity(
                combined_text
            )

            # Initialize scoring object if it doesn't exist
            if "Scoring" not in product:
                product["Scoring"] = {}

            product["Scoring"]["semantic_score"] = semantic_score
            product["Scoring"]["semantic_breakdown"] = semantic_breakdown

        return products


class SalmonFilterPipeline:
    """Pipeline that applies multiple filters in sequence using dependency injection"""

    def __init__(self, filters: typing.List[ProductFilter]):
        self.filters = filters

    def process(self, products: typing.List[typing.Dict]) -> typing.List[typing.Dict]:
        """Apply all filters in sequence"""
        current_products = products
        for filter_instance in self.filters:
            current_products = filter_instance.filter_products(current_products)
        return current_products


class CombinedScoreCalculator:
    """Combines rule-based and semantic scores"""

    def __init__(self, rule_weight: float = 0.7, semantic_weight: float = 0.3):
        self.rule_weight = rule_weight
        self.semantic_weight = semantic_weight

    def calculate_final_score(
        self, products: typing.List[typing.Dict]
    ) -> typing.List[typing.Dict]:
        """Calculate weighted combined score"""
        for product in products:
            # Initialize scoring object if it doesn't exist
            if "Scoring" not in product:
                product["Scoring"] = {}

            rule_score = product["Scoring"].get("rule_score", 0)
            semantic_score = product["Scoring"].get("semantic_score", 0)

            # Normalize rule score to 0-1 range (assuming max rule score around 20)
            normalized_rule = min(rule_score / 20, 1.0) if rule_score > 0 else 0

            final_score = (normalized_rule * self.rule_weight) + (
                semantic_score * self.semantic_weight
            )

            product["Scoring"]["final_score"] = round(final_score, 2)
            product["Scoring"]["weights"] = {
                "rule_weight": self.rule_weight,
                "semantic_weight": self.semantic_weight,
                "normalized_rule_score": normalized_rule,
            }

        return products


def load_input_data(input_source: typing.Optional[str]) -> typing.List[typing.Dict]:
    """Load data from file or stdin"""
    try:
        if input_source is None or input_source == "-":
            # Read from stdin
            data = json.load(sys.stdin)
        else:
            # Read from file
            with open(input_source, "r", encoding="utf-8") as f:
                data = json.load(f)

        if not isinstance(data, list):
            raise ValueError("Input data must be a JSON array")

        return data

    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format: {e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print(f"Error: Could not find file {input_source}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error loading input data: {e}", file=sys.stderr)
        sys.exit(1)


def main():
    """Main entry point with CLI argument parsing"""
    parser = argparse.ArgumentParser(description="Salmon product filter transformer")
    parser.add_argument(
        "--input", "-i", help="Input JSON file (use - or omit for stdin)", default=None
    )
    parser.add_argument(
        "--rule-weight",
        type=float,
        default=0.7,
        help="Weight for rule-based scoring (default: 0.7)",
    )
    parser.add_argument(
        "--semantic-weight",
        type=float,
        default=0.3,
        help="Weight for semantic scoring (default: 0.3)",
    )

    args = parser.parse_args()

    # Load input data
    products_data = load_input_data(args.input)

    # Initialize filters
    rule_filter = RuleBasedSalmonFilter()
    semantic_filter = SemanticSalmonFilter()

    # Create pipeline with dependency injection
    pipeline = SalmonFilterPipeline([rule_filter, semantic_filter])

    # Process products through pipeline
    filtered_products = pipeline.process(products_data)

    # Calculate combined scores
    score_calculator = CombinedScoreCalculator(
        rule_weight=args.rule_weight, semantic_weight=args.semantic_weight
    )
    final_products = score_calculator.calculate_final_score(filtered_products)

    # Output as JSON
    print(json.dumps(final_products, indent=2))


if __name__ == "__main__":
    main()
