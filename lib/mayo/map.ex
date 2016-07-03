defmodule Mayo.Map do
  @doc """
  Checks the minimum number of the keys in the map.

      iex> Mayo.Map.min(%{foo: "bar"}, 1)
      %{foo: "bar"}

      iex> Mayo.Map.min(%{}, 1)
      {:error, %Mayo.Error{type: "map.min"}}
  """
  def min(value, len) when is_map(value) do
    if length(Map.keys(value)) < len do
      {:error, %Mayo.Error{
        type: "map.min"
      }}
    else
      value
    end
  end

  def min(value, _), do: value

  @doc """
  Checks the maximum number of the keys in the map.

      iex> Mayo.Map.max(%{foo: "bar"}, 1)
      %{foo: "bar"}

      iex> Mayo.Map.max(%{foo: "bar", baz: "boo"}, 1)
      {:error, %Mayo.Error{type: "map.max"}}
  """
  def max(value, len) when is_map(value) do
    if length(Map.keys(value)) > len do
      {:error, %Mayo.Error{
        type: "map.max"
      }}
    else
      value
    end
  end

  def max(value, _), do: value

  @doc """
  Checks the number of the keys in the map.

      iex> Mayo.Map.length(%{foo: "bar"}, 1)
      %{foo: "bar"}

      iex> Mayo.Map.length(%{}, 1)
      {:error, %Mayo.Error{type: "map.length"}}
  """
  def length(value, len) when is_map(value) do
    if length(Map.keys(value)) == len do
      value
    else
      {:error, %Mayo.Error{
        type: "map.length"
      }}
    end
  end

  def length(value, _), do: value

  @doc """
  Checks the presence of keys.

      iex> Mayo.Map.with(%{foo: "bar", baz: "boo"}, [:foo, :baz])
      %{foo: "bar", baz: "boo"}

      iex> Mayo.Map.with(%{foo: "bar"}, [:foo, :baz])
      {:error, %Mayo.Error{type: "map.with", paths: [:baz]}}
  """
  def with(value, peers) when is_map(value) do
    Enum.reduce peers, value, fn key, acc ->
      case acc do
        {:error, _} = err -> err

        _ ->
          case Map.fetch(acc, key) do
            :error -> {:error, %Mayo.Error{
              paths: [key],
              type: "map.with"
            }}

            _ -> acc
          end
      end
    end
  end

  def with(value, _), do: value

  @doc """
  Forbids the presence of keys.

      iex> Mayo.Map.without(%{foo: "bar"}, [:baz, :boo])
      %{foo: "bar"}

      iex> Mayo.Map.without(%{foo: "bar", baz: "boo"}, [:baz, :boo])
      {:error, %Mayo.Error{type: "map.without", paths: [:baz]}}
  """
  def without(value, peers) when is_map(value) do
    Enum.reduce peers, value, fn key, acc ->
      case acc do
        {:error, _} = err -> err

        _ ->
          case Map.fetch(acc, key) do
            :error -> acc

            _ -> {:error, %Mayo.Error{
              paths: [key],
              type: "map.without"
            }}
          end
      end
    end
  end

  def without(value, _), do: value

  @doc """
  Rename a key to another name.

      iex> Mayo.Map.rename(%{foo: "bar"}, :foo, :baz)
      %{baz: "bar"}

      iex> Mayo.Map.rename(%{foo: "bar"}, :bar, :baz)
      %{foo: "bar"}
  """
  def rename(value, from, to) when is_map(value) do
    case Map.fetch(value, from) do
      {:ok, result} ->
        Map.put(value, to, result)
        |> Map.delete(from)

      :error -> value
    end
  end

  def rename(value, _, _), do: value
end
