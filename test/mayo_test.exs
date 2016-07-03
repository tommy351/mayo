defmodule MayoTest do
  use ExUnit.Case
  doctest Mayo

  test "map" do
    result = Mayo.validate %{}, %{
      username: Mayo.Any.string |> Mayo.String.min(4)
    }

    assert result == %{}

    result = Mayo.validate %{}, %{
      username: Mayo.Any.string |> Mayo.Any.required |> Mayo.String.min(4)
    }

    assert result == {:error, %Mayo.Error{type: "any.required", paths: [:username]}}
  end

  test "nested map" do
    result = Mayo.validate %{
      payload: %{
        username: "jo"
      }
    }, %{
      payload: %{
        username: Mayo.Any.string |> Mayo.String.min(4)
      }
    }

    assert result == {:error, %Mayo.Error{type: "string.min", paths: [:payload, :username]}}
  end

  test "keyword list" do
    result = Mayo.validate [], [
      username: Mayo.Any.string |> Mayo.String.min(4)
    ]

    assert result == []

    result = Mayo.validate [], [
      username: Mayo.Any.string |> Mayo.Any.required |> Mayo.String.min(4)
    ]

    assert result == {:error, %Mayo.Error{type: "any.required", paths: [:username]}}
  end
end
