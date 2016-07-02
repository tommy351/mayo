defmodule Mayo.String do
  def min(value, len) do
    if String.length(value) < len do
      {:error, %Mayo.Error{
        type: "string.min"
      }}
    else
      value
    end
  end

  def max(value, len) do
    if String.length(value) > len do
      {:error, %Mayo.Error{
        type: "string.max"
      }}
    else
      value
    end
  end

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
