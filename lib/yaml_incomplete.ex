defmodule YamlIncomplete do
  @moduledoc """
  A very barebone `YAML` dumper. Not a `YAML` parser.
  Converts a data structure to `YAML` if:
  * no tuples involved;
  * no structs.

  Only handles Maps or Lists of Integers, Strings and nil.
  ## Examples

      iex> YamlIncomplete.to_yaml(%{a: [1, 2]})
      "---
      :a:
      - 1
      - 2
      "

  """

  def to_yaml(data) do
    "---\n#{to_yaml(data, 0)}\n"
  end

  @doc """
  Converts nil to yaml.

  ## Examples

      iex> YamlIncomplete.to_yaml(nil, 0)
      ""
  """

  def to_yaml(term, indent) when is_nil(term) do
    String.pad_leading("", indent)
  end

  @doc """
  Converts Strings to yaml.

  ## Examples

      iex> YamlIncomplete.to_yaml("hallo world", 0)
      "hallo world"

  """
  def to_yaml(term, indent) when is_bitstring(term) do
    pad("#{term}", indent)
  end

  @doc """
  Converts Atoms to yaml.

  ## Examples

      iex> YamlIncomplete.to_yaml(:a, 0)
      ":a"

  """
  def to_yaml(term, indent) when is_atom(term) do
    pad(":#{Atom.to_string(term)}", indent)
  end

  @doc """
  Converts Integers to yaml.

  ## Examples

      iex> YamlIncomplete.to_yaml(12, 0)
      "12"

  """
  def to_yaml(term, indent) when is_integer(term) do
    pad("#{Integer.to_string(term)}", indent)
  end

  def to_yaml([], indent) do
    pad("[]", indent)
  end

  @doc """
  Converts lists to yaml.

  """
  def to_yaml(term, indent) when is_list(term) do
    term
    |> Enum.map(fn
      el when is_integer(el) or is_nil(el) or is_bitstring(el) ->
        pad("- #{to_yaml(el, 0)}", indent)

      el when is_map(el) ->
        "- #{to_yaml(el, indent + 2)}"

      el ->
        "#{pad("-", indent)}\n#{to_yaml(el, indent + 2)}"
    end)
    |> Enum.join("\n")
  end

  @doc """
  Converts maps to yaml.

  """
  def to_yaml(term, indent) when is_map(term) do
    Map.to_list(term)
    |> Enum.map(fn
      {k, v} when is_integer(v) or is_nil(v) or is_bitstring(v) ->
        # indent is zero because indentation is handled by join (last line)
        "#{to_yaml(k, 0)}: #{to_yaml(v, 0)}"

      {k, []} ->
        "#{to_yaml(k, 0)}: #{to_yaml([], 0)}"

      {k, v} ->
        pad("#{to_yaml(k, 0)}:\n#{to_yaml(v, 0)}", indent)
    end)
    |> Enum.join("\n#{String.duplicate(" ", indent)}")
  end

  @doc """
  Left padding utility private function

  ## Examples

      iex> YamlIncomplete.pad("hello", 2)
      "  hello"

  """
  defp pad(term, indent) do
    String.pad_leading(term, indent + String.length(term))
  end
end
