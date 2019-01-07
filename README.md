# YamlIncomplete

A very barebone `YAML` dumper. Not a `YAML` parser. 
Converts a data structure to `YAML` if:
* no tuples involved;
* no structs.

Only handles Maps or Lists of Integers, Strings and nil.

## Usage

    iex> YamlIncomplete.to_yaml(%{a: [1, 2]})
    ---
    :a:
    - 1
    - 2

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `yaml_incomplete` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:yaml_incomplete, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/yaml_incomplete](https://hexdocs.pm/yaml_incomplete).

