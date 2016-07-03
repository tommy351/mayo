defmodule MayoTest do
  use ExUnit.Case
  doctest Mayo

  test "map" do
    result = Mayo.validate %{
      username: "test"
    }, %{
      username: Mayo.Any.string |> Mayo.String.min(4)
    }

    assert result == %{username: "test"}

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
    result = Mayo.validate [
      username: "test"
    ], [
      username: Mayo.Any.string |> Mayo.String.min(4)
    ]

    assert result == [username: "test"]

    result = Mayo.validate [], [
      username: Mayo.Any.string |> Mayo.Any.required |> Mayo.String.min(4)
    ]

    assert result == {:error, %Mayo.Error{type: "any.required", paths: [:username]}}
  end

  test "map pipe" do
    result = Mayo.validate %{
      username: "test"
    }, %{
      username: Mayo.Any.string
    } |> Mayo.Map.with([:username, :password])

    assert result == {:error, %Mayo.Error{type: "map.with", paths: [:password]}}
  end

  test "list pipe" do
    result = Mayo.validate [
      username: "test"
    ], [
      username: Mayo.Any.string
    ] |> Mayo.List.min(2)

    assert result == {:error, %Mayo.Error{type: "list.min"}}
  end
end
