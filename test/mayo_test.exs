defmodule MayoTest do
  use ExUnit.Case
  require Mayo
  doctest Mayo

  test "the truth" do
    data = %{
      username: "tommy351"
    }

    # Mayo.validate data, Mayo.Map.keys(%{
    #   username: Mayo.Any.string
    # }) |> Mayo.Map.with([:username])

    result = Mayo.validate "test", Mayo.Any.string |> Mayo.String.min(4)
    IO.inspect result
    # schema = Mayo.schema Mayo.Map.keys(%{})
    #
    # Mayo.validate %{}, schema
    # Mayo.validate %{}, Mayo.Map.keys(%{})
    # Mayo.validate data, Mayo.Map.keys(%{
    #   username: Mayo.Any.string |> Mayo.String.min(4) |> Mayo.String.max(255)
    # })
    # assert 1 + 1 == 2
  end
end
