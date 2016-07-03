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

  @doc """
  Checks if the value is an atom.

      iex> Mayo.Any.atom(:test)
      :test

      iex> Mayo.Any.atom("test")
      {:error, %Mayo.Error{type: "any.atom"}}
  """
  def atom(value) when is_atom(value) or is_nil(value), do: value

  def atom(_) do
    {:error, %Mayo.Error{
      type: "any.atom"
    }}
  end

  @doc """
  Checks if the value is a list.

      iex> Mayo.Any.list([1, 2, 3])
      [1, 2, 3]

      iex> Mayo.Any.list("test")
      {:error, %Mayo.Error{type: "any.list"}}
  """
  def list(value) when is_list(value) or is_nil(value), do: value

  def list(_) do
    {:error, %Mayo.Error{
      type: "any.list"
    }}
  end

  @doc """
  Forbids any value except `nil`.

      iex> Mayo.Any.forbidden(nil)
      nil

      iex> Mayo.Any.forbidden("test")
      {:error, %Mayo.Error{type: "any.forbidden"}}
  """
  def forbidden(value) when is_nil(value), do: value

  def forbidden(_) do
    {:error, %Mayo.Error{
      type: "any.forbidden"
    }}
  end

  @doc """
  Sets the value to `nil`. Used to sanitize output.

      iex> Mayo.Any.strip("test")
      nil

      iex> Mayo.Any.strip(nil)
      nil
  """
  def strip(_), do: nil
end
