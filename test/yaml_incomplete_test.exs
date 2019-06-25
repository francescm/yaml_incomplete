defmodule YamlIncompleteTest do
  use ExUnit.Case
  doctest YamlIncomplete

  test "converts nil to yaml" do
    assert YamlIncomplete.to_yaml(nil, 0) == ""
  end

  test "converts atoms to yaml" do
    assert YamlIncomplete.to_yaml(:a, 0) == ":a"
  end

  test "converts integers to yaml" do
    assert YamlIncomplete.to_yaml(123, 0) == "123"
  end

  test "converts lists to yaml" do
    assert YamlIncomplete.to_yaml([1, 2], 0) == "- 1\n- 2"
  end

  test "converts nested lists to yaml" do
    assert YamlIncomplete.to_yaml([1, [2, 3]], 0) == "- 1\n-\n  - 2\n  - 3"
  end

  test "converts mixed nested lists to yaml" do
    assert YamlIncomplete.to_yaml([1, ["hello", nil]], 0) == "- 1\n-\n  - \"hello\"\n  - "
  end

  test "converts empty lists to yaml" do
    assert YamlIncomplete.to_yaml([], 0) == "[]"
  end

  test "converts basic maps to yaml" do
    assert YamlIncomplete.to_yaml(%{a: 1}, 0) == ":a: 1"
  end

  test "converts nested maps to yaml" do
    assert YamlIncomplete.to_yaml(%{a: [1, 2]}, 0) == ":a:\n- 1\n- 2"
  end

  test "converts maps of maps to yaml" do
    assert YamlIncomplete.to_yaml(%{a: [%{d: 2, f: 3}]}, 0) == ":a:\n- :d: 2\n  :f: 3"
  end

  test "converts maps with empty list to yaml" do
    assert YamlIncomplete.to_yaml(%{a: []}, 0) == ":a: []"
  end

  test "converts maps with deeply nested list to yaml" do
    assert YamlIncomplete.to_yaml(
             %{"usernames" => [%{"USERNAME" => ["john_doe"], "active" => ["true"]}]},
             0
           ) == "\"usernames\":\n- \"USERNAME\":\n  - \"john_doe\"\n  \"active\":\n  - \"true\""
  end
end
