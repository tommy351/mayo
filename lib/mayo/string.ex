defmodule Mayo.String do
  # http://stackoverflow.com/a/13653180
  @uuid_pattern ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/

  # https://github.com/hapijs/joi/blob/v8.4.2/lib/string.js#L375
  @hex_pattern ~r/^[a-f0-9]+$/i

  # https://github.com/hapijs/joi/blob/v8.4.2/lib/string.js#L170
  @alphanum_pattern ~r/^[a-zA-Z0-9]+$/

  # https://github.com/hapijs/joi/blob/v8.4.2/lib/string.js#L170
  @token_pattern ~r/^\w+$/

  @doc """
  Checks the minimum length of a string.

      iex> Mayo.String.min("test", 3)
      "test"

      iex> Mayo.String.min("t", 3)
      {:error, %Mayo.Error{type: "string.min"}}
  """
  def min(value, len) when is_binary(value) do
    if String.length(value) < len do
      {:error, %Mayo.Error{
        type: "string.min"
      }}
    else
      value
    end
  end

  def min(value, _), do: value

  @doc """
  Checks the maximum length of a string.

      iex> Mayo.String.max("test", 5)
      "test"

      iex> Mayo.String.max("bucket", 5)
      {:error, %Mayo.Error{type: "string.max"}}
  """
  def max(value, len) when is_binary(value) do
    if String.length(value) > len do
      {:error, %Mayo.Error{
        type: "string.max"
      }}
    else
      value
    end
  end

  def max(value, _), do: value

  @doc """
  Checks the length of a string.

      iex> Mayo.String.length("test", 4)
      "test"

      iex> Mayo.String.length("test", 5)
      {:error, %Mayo.Error{type: "string.length"}}
  """
  def length(value, len) when is_binary(value) do
    if String.length(value) == len do
      value
    else
      {:error, %Mayo.Error{
        type: "string.length"
      }}
    end
  end

  def length(value, _), do: value

  @doc """
  Checks if the string is a valid UUID.

      iex> Mayo.String.uuid("127862fc-3f59-47c4-9ccf-5d3bfbbe1271")
      "127862fc-3f59-47c4-9ccf-5d3bfbbe1271"

      iex> Mayo.String.uuid("test")
      {:error, %Mayo.Error{type: "string.uuid"}}
  """
  def uuid(value) when is_binary(value) do
    if String.match?(value, @uuid_pattern) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.uuid"
      }}
    end
  end

  def uuid(value), do: value

  @doc """
  Checks if the string only contains hex.

      iex> Mayo.String.hex("a1b2")
      "a1b2"

      iex> Mayo.String.hex("lol")
      {:error, %Mayo.Error{type: "string.hex"}}
  """
  def hex(value) when is_binary(value) do
    if String.match?(value, @hex_pattern) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.hex"
      }}
    end
  end

  def hex(value), do: value

  @doc """
  Checks if the string is a valid IPv4 or IPv6 address.

      iex> Mayo.String.ip("210.59.230.150")
      "210.59.230.150"

      iex> Mayo.String.ip("2001:0DB8:02de:0000:0000:0000:0000:0e13")
      "2001:0DB8:02de:0000:0000:0000:0000:0e13"

      iex> Mayo.String.ip("test")
      {:error, %Mayo.Error{type: "string.ip"}}
  """
  def ip(value) when is_binary(value) do
    case to_char_list(value) |> :inet.parse_address do
      {:ok, _} -> value
      _ -> {:error, %Mayo.Error{
        type: "string.ip"
      }}
    end
  end

  def ip(value), do: value

  @doc """
  Checks if the string matches the pattern.

      iex> Mayo.String.match("abbbbbc", ~r/^ab+c$/)
      "abbbbbc"

      iex> Mayo.String.match("ac", ~r/^ab+c$/)
      {:error, %Mayo.Error{type: "string.match"}}
  """
  def match(value, pattern) when is_binary(value) do
    if String.match?(value, pattern) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.match"
      }}
    end
  end

  def match(value, _), do: value

  @doc """
  Checks if the string is a valid Luhn number. (Use [luhn_ex](https://github.com/ma2gedev/luhn_ex) library)

      iex> Mayo.String.credit_card("378282246310005")
      "378282246310005"

      iex> Mayo.String.credit_card("123456789123456")
      {:error, %Mayo.Error{type: "string.credit_card"}}
  """
  def credit_card(value) when is_binary(value) do
    if Luhn.valid?(value) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.credit_card"
      }}
    end
  end

  def credit_card(value), do: value

  @doc """
  Checks if the string only contains a-z, A-Z, and 0-9.

      iex> Mayo.String.alphanum("Aa0")
      "Aa0"

      iex> Mayo.String.alphanum("!$!")
      {:error, %Mayo.Error{type: "string.alphanum"}}
  """
  def alphanum(value) when is_binary(value) do
    if String.match?(value, @alphanum_pattern) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.alphanum"
      }}
    end
  end

  def alphanum(value), do: value

  @doc """
  Checks if the string only contains a-z, A-Z, 0-9 and underscore _.

      iex> Mayo.String.token("t_z")
      "t_z"

      iex> Mayo.String.token("t!z")
      {:error, %Mayo.Error{type: "string.token"}}
  """
  def token(value) when is_binary(value) do
    if String.match?(value, @token_pattern) do
      value
    else
      {:error, %Mayo.Error{
        type: "string.token"
      }}
    end
  end

  def token(value), do: value
end
