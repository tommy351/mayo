defmodule Mayo.List do
  @doc """
  Checks the minimum number of elements in the list.

      iex> Mayo.List.min([1, 2, 3], 3)
      [1, 2, 3]

      iex> Mayo.List.min([], 3)
      {:error, %Mayo.Error{type: "list.min"}}
  """
  def min(value, len) when is_list(value) and length(value) == len, do: value

  def min(value, _) when is_list(value) do
    {:error, %Mayo.Error{
      type: "list.min"
    }}
  end

  def min(value, _), do: value

  @doc """
  Checks the maximum number of elements in the list.

      iex> Mayo.List.max([1, 2, 3], 3)
      [1, 2, 3]

      iex> Mayo.List.max([1, 2, 3, 4], 3)
      {:error, %Mayo.Error{type: "list.max"}}
  """
  def max(value, len) when is_list(value) and length(value) == len, do: value

  def max(value, _) when is_list(value) do
    {:error, %Mayo.Error{
      type: "list.max"
    }}
  end

  def max(value, _), do: value

  @doc """
  Checks the number of elements in the list.

      iex> Mayo.List.length([1, 2, 3], 3)
      [1, 2, 3]

      iex> Mayo.List.length([1], 3)
      {:error, %Mayo.Error{type: "list.length"}}
  """
  def length(value, len) when is_list(value) and length(value) == len, do: value

  def length(value, _) when is_list(value) do
    {:error, %Mayo.Error{
      type: "list.length"
    }}
  end

  def length(value, _), do: value
end
