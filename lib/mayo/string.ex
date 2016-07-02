defmodule Mayo.String do
  @doc """
  Checks the minimum length of a string.

      iex> Mayo.String.min("test", 3)
      "test"

      iex> Mayo.String.min("t", 3)
      {:error, %Mayo.Error{type: "string.min"}}
  """
  def min(value, len) do
    if String.length(value) < len do
      {:error, %Mayo.Error{
        type: "string.min"
      }}
    else
      value
    end
  end

  @doc """
  Checks the maximum length of a string.

      iex> Mayo.String.max("test", 5)
      "test"

      iex> Mayo.String.max("bucket", 5)
      {:error, %Mayo.Error{type: "string.max"}}
  """
  def max(value, len) do
    if String.length(value) > len do
      {:error, %Mayo.Error{
        type: "string.max"
      }}
    else
      value
    end
  end

  @doc """
  Checks the length of a string.

      iex> Mayo.String.length("test", 4)
      "test"

      iex> Mayo.String.length("test", 5)
      {:error, %Mayo.Error{type: "string.length"}}
  """
  def length(value, len) do
    if String.length(value) == len do
      value
    else
      {:error, %Mayo.Error{
        type: "string.length"
      }}
    end
  end
end
