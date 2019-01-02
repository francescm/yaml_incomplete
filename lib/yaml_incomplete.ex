defmodule YamlIncomplete do
  @moduledoc """
  Documentation for YamlIncomplete.
  """

  @doc """
  Hello world.

  ## Examples

      iex> YamlIncomplete.hello()
      :world

  """
  def hello do
    :world
  end

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

  @doc """
  Converts lists to yaml.

  """
  def to_yaml(term, indent) when is_list(term) do
    term |> Enum.map(fn
    el when is_integer(el) or is_nil(el) or is_bitstring(el) -> pad("- #{to_yaml(el, 0)}", indent)
    el -> "#{pad("-", indent)}\n#{to_yaml(el, indent + 2)}"
    end) |> Enum.join("\n")
  end

  @doc """
  Converts maps to yaml.

  """
  def to_yaml(term, indent) when is_map(term) do
    Map.to_list(term) |> Enum.map(fn
      {k, v} when is_integer(v) or is_nil(v) or is_bitstring(v) -> pad("#{to_yaml(k, 0)}: #{to_yaml(v, 0)}", indent)
      {k, v} -> pad("#{to_yaml(k, 0)}:\n#{to_yaml(v, 2)}", indent)
    end) |> Enum.join
  end


  @doc """
  Converts Integers to yaml.

  ## Examples

      iex> YamlIncomplete.pad("hello", 2)
      "  hello"

  """
  defp pad(term, indent) do
    String.pad_leading(term, indent + String.length(term))
  end

end
