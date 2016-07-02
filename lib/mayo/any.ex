defmodule Mayo.Any do
  def required(value) when is_nil(value) do
    {:error, %Mayo.Error{
      type: "any.required"
    }}
  end

  def required(value), do: value

  def default(value, default) when is_nil(value), do: default
  def default(value, _), do: value

  def string(value) when is_binary(value), do: value

  def string(_) do
    {:error, %Mayo.Error{
      type: "any.string"
    }}
  end

  def boolean(value) when is_boolean(value), do: value
  def boolean(value) when value in ["true", "yes", "on", "1", 1], do: true
  def boolean(value) when value in ["false", "no", "off", "0", 0], do: false

  def boolean(_) do
    {:error, %Mayo.Error{
      type: "any.boolean"
    }}
  end

  def number(value) when is_number(value), do: value

  def number(_) do
    {:error, %Mayo.Error{
      type: "any.number"
    }}
  end
end
