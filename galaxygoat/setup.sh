#!/bin/bash
# Kedro Spaceflights Project Setup Script with uv and automated cookiecutter prompts
# Exit on any error
set -e

# Create project directory
mkdir -p spaceflights
cd spaceflights

# Create and activate virtual environment using uv
echo "Creating virtual environment..."
uv venv --python "<3.12"

# Activate the virtual environment
source .venv/bin/activate

# Create requirements file
cat >requirements.txt <<EOL
# Kedro and related dependencies
kedro~=0.19.0
kedro-datasets[pandas-csvdataset,pandas-exceldataset,pandas-parquetdataset]>=3.0
kedro-telemetry>=0.3.1
kedro-viz~=6.0
cookiecutter>=2.0.0
# Code quality and development
ruff==0.1.8
ipython~=8.10
# Notebook tooling
jupyter~=1.0
jupyterlab~=3.0
# Testing
pytest-cov~=3.0
pytest-mock>=1.7.1, <2.0
pytest~=7.2
# Data science
scikit-learn~=1.0
EOL

# Install dependencies using uv
echo "Installing project dependencies..."
uv pip install -r requirements.txt

# Create configuration file for cookiecutter
cat >cookiecutter.json <<EOL
{
    "project_name": "Spaceflights Pandas",
    "python_package": "spaceflights_pandas",
    "project_description": "A Kedro project for space travel data analysis",
    "author_name": "Your Name",
    "author_email": "your.email@example.com",
    "repo_name": "spaceflights-pandas"
}
EOL

# Create Spaceflights project with predefined configuration
echo "Creating Spaceflights Kedro project..."
kedro new --starter=spaceflights-pandas --config=cookiecutter.json

# Optional: Initialize git repository
if command -v git &>/dev/null; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Kedro Spaceflights project setup with uv"
fi

# Print completion message
echo "Kedro Spaceflights project setup complete!"
echo "Next steps:"
echo "1. Activate the virtual environment: source .venv/bin/activate"
echo "2. Navigate to the project directory"
echo "3. Run Kedro commands or start developing your project"

# Optional: show project structure
echo "Project structure:"
tree -L 2

# Deactivate virtual environment
deactivate
