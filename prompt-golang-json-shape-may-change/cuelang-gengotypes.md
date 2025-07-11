$ cue help exp gengotypes
ARNING: THIS COMMAND IS EXPERIMENTAL.

gengotypes generates Go type definitions from exported CUE definitions.

The generated Go types are guaranteed to accept any value accepted by the CUE definitions,
but may be more general. For example, "string | int" will translate into the Go
type "any" because the Go type system is not able to express disjunctions.

To ensure that the resulting Go code works, any imported CUE packages or
referenced CUE definitions are transitively generated as well.
Generated code is placed in cue_types*_gen.go files in each CUE package directory.

Generated Go type and field names may differ from the original CUE names by default.
For instance, an exported definition "#foo" becomes "Foo",
and a nested definition like "#foo.#bar" becomes "Foo_Bar".

@go attributes can be used to override which name to be generated:

	package foo
	@go(betterpkgname)

	#Bar: {
		@go(BetterBarTypeName)
		renamed: int @go(BetterFieldName)
	}

The attribute "@go(-)" can be used to ignore a definition or field:

	#ignoredDefinition: {
		@go(-)
	}
	ignoredField: int @go(-)

"type=" overrides an entire value to generate as a given Go type expression:

	retypedLocal:  [string]: int @go(,type=map[LocalType]int)
	retypedImport: [...string]   @go(,type=[]"foo.com/bar".ImportedType)

"optional=" controls how CUE optional fields are generated as Go fields.
The default is "zero", representing a missing field as the zero value.
"nillable" ensures the generated Go type can represent missing fields as nil.

	optionalDefault?:  int                         // generates as "int64"
	optionalNillable?: int @go(,optional=nillable) // generates as "*int64"
	nested: {
		@go(,optional=nillable) // set for all fields under this struct
	}

Usage:
  cue exp gengotypes [flags]

Global Flags:
  -E, --all-errors   print all available errors
  -i, --ignore       proceed in the presence of errors
  -s, --simplify     simplify output
      --trace        trace computation
  -v, --verbose      print information about progress
