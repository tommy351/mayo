defmodule Mayo.Number do
  def min(value, limit) when value >= limit, do: value

  def min(value, _) do
    {:error, %Mayo.Error{
      type: "number.min"
    }}
  end

  def max(value, limit) when value <= limit, do: value

  def max(value, _) do
    {:error, %Mayo.Error{
      type: "number.max"
    }}
  end

  def positive(value) when value >= 0, do: value

  def positive(value) do
    {:error, %Mayo.Error{
      type: "number.positive"
    }}
  end

  def negative(value) when value <= 0, do: value

  def negative(value) do
    {:error, %Mayo.Error{
      type: "number.negative"
    }}
  end
end
