defmodule Mayo.Any do
  @doc """
  Checks if the value is nil.

      iex> Mayo.Any.required("test")
      "test"

      iex> Mayo.Any.required(nil)
      {:error, %Mayo.Error{type: "any.required"}}
  """
  def required(value) when is_nil(value) do
    {:error, %Mayo.Error{
      type: "any.required"
    }}
  end

  def required(value), do: value

  @doc """
  Sets to the default value if the value is nil.

      iex> Mayo.Any.default("test", "default")
      "test"

      iex> Mayo.Any.default(nil, "default")
      "default"
  """
  def default(value, default) when is_nil(value), do: default
  def default(value, _), do: value

  @doc """
  Checks if the value is a string.

      iex> Mayo.Any.string("test")
      "test"

      iex> Mayo.Any.string(23)
      {:error, %Mayo.Error{type: "any.string"}}
  """
  def string(value) when is_binary(value) or is_nil(value), do: value

  def string(_) do
    {:error, %Mayo.Error{
      type: "any.string"
    }}
  end

  @doc """
  Checks if the value is a boolean or `true`, `false`, `yes`, `no`,
  `on`, `off`, `1`, `0`.

      iex> Mayo.Any.boolean(true)
      true

      iex> Mayo.Any.boolean("yes")
      true

      iex> Mayo.Any.boolean("foo")
      {:error, %Mayo.Error{type: "any.boolean"}}
  """
  def boolean(value) when is_boolean(value) or is_nil(value), do: value
  def boolean(value) when value in ["true", "yes", "on", "1", 1], do: true
  def boolean(value) when value in ["false", "no", "off", "0", 0], do: false

  def boolean(_) do
    {:error, %Mayo.Error{
      type: "any.boolean"
    }}
  end

  @doc """
  Checks if the value is a number.

      iex> Mayo.Any.number(23)
      23

      iex> Mayo.Any.number("test")
      {:error, %Mayo.Error{type: "any.number"}}
  """
  def number(value) when is_number(value) or is_nil(value), do: value

  def number(_) do
    {:error, %Mayo.Error{
      type: "any.number"
    }}
  end

  @doc """
  Checks if the value is a map.

      iex> Mayo.Any.map(%{username: "test"})
      %{username: "test"}

      iex> Mayo.Any.map("test")
      {:error, %Mayo.Error{type: "any.map"}}
  """
  def map(value) when is_map(value) or is_nil(value), do: value

  def map(_) do
    {:error, %Mayo.Error{
      type: "any.map"
    }}
  end
end
