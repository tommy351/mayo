defmodule Mayo.Number do
  @doc """
  Checks the minimum value of a number.

      iex> Mayo.Number.min(4, 3)
      4

      iex> Mayo.Number.min(1, 3)
      {:error, %Mayo.Error{type: "number.min"}}
  """
  def min(value, limit) when is_number(value) and value >= limit, do: value

  def min(value, _) when is_number(value) do
    {:error, %Mayo.Error{
      type: "number.min"
    }}
  end

  def min(value, _), do: value

  @doc """
  Checks the maximum value of a number.

      iex> Mayo.Number.max(4, 5)
      4

      iex> Mayo.Number.max(6, 5)
      {:error, %Mayo.Error{type: "number.max"}}
  """
  def max(value, limit) when is_number(value) and value <= limit, do: value

  def max(value, _) when is_number(value) do
    {:error, %Mayo.Error{
      type: "number.max"
    }}
  end

  def max(value, _), do: value

  @doc """
  Checks if the number is positive.

      iex> Mayo.Number.positive(2)
      2

      iex> Mayo.Number.positive(0)
      0

      iex> Mayo.Number.positive(-2)
      {:error, %Mayo.Error{type: "number.positive"}}
  """
  def positive(value) do
    case Mayo.Number.min(value, 0) do
      {:error, err} -> {:error, %{err | type: "number.positive"}}
      result -> result
    end
  end

  @doc """
  Checks if the number is negative.

      iex> Mayo.Number.negative(-2)
      -2

      iex> Mayo.Number.negative(0)
      0

      iex> Mayo.Number.negative(2)
      {:error, %Mayo.Error{type: "number.negative"}}
  """
  def negative(value) do
    case Mayo.Number.max(value, 0) do
      {:error, err} -> {:error, %{err | type: "number.negative"}}
      result -> result
    end
  end

  @doc """
  Check if the number is odd.

      iex> Mayo.Number.odd(1)
      1

      iex> Mayo.Number.odd(2)
      {:error, %Mayo.Error{type: "number.odd"}}
  """
  def odd(value) when is_number(value) and rem(value, 2) != 0, do: value

  def odd(value) when is_number(value) do
    {:error, %Mayo.Error{
      type: "number.odd"
    }}
  end

  def odd(value), do: value

  @doc """
  Check if the number is even.

      iex> Mayo.Number.even(2)
      2

      iex> Mayo.Number.even(1)
      {:error, %Mayo.Error{type: "number.even"}}
  """
  def even(value) when is_number(value) and rem(value, 2) == 0, do: value

  def even(value) when is_number(value) do
    {:error, %Mayo.Error{
      type: "number.even"
    }}
  end

  def even(value), do: value
end
