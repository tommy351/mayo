defmodule Mayo do
  @doc """
  Validates data with a schema.

      iex> Mayo.validate "test", Mayo.String.min(4) |> String.capitalize
      "Test"

      iex> Mayo.validate 42, Mayo.Number.max(23)
      {:error, %Mayo.Error{type: "number.max"}}

      iex> Mayo.validate %{username: "johndoe"}, %{
      ...>   username: Mayo.Any.string |> Mayo.String.min(6)
      ...> }
      %{username: "johndoe"}

      iex> Mayo.validate %{username: "test"}, %{
      ...>   username: Mayo.Any.string |> Mayo.String.min(6)
      ...> }
      {:error, %Mayo.Error{type: "string.min", paths: [:username]}}
  """
  defmacro validate(value, schema) do
    compile(schema, value)
  end

  defp compile(schema, value) do
    pipes = unpipe_schema(schema)
    Enum.reduce(pipes, value, &reduce_pipes/2)
  end

  defp unpipe_schema({op, _, _} = schema) when op == :|> do
    Macro.unpipe(schema)
  end

  defp unpipe_schema(schema) do
    [{schema, 0}]
  end

  defp reduce_pipes({pipe, _}, acc) do
    pipe = compile_pipe(pipe, acc)

    quote do
      case unquote(acc) do
        {:error, _} -> unquote(acc)
        _ -> unquote(pipe)
      end
    end
  end

  defp compile_pipe({:%{}, _, args}, value) do
    Enum.reduce(args, value, &reduce_map_pipes/2)
  end

  defp compile_pipe({op, meta, args}, value) do
    {op, meta, [value | args]}
  end

  defp reduce_map_pipes({key, pipes}, acc) do
    item = quote do: Map.get(unquote(acc), unquote(key))
    pipe = compile(pipes, item)

    quote do
      case unquote(acc) do
        {:error, _} -> unquote(acc)

        _ ->
          case unquote(pipe) do
            result when is_nil(result) ->
              unquote(acc)

            {:error, %Mayo.Error{paths: paths} = err} ->
              {:error, %{err | paths: [unquote(key) | paths]}}

            result ->
              Map.put(unquote(acc), unquote(key), result)
          end
      end
    end
  end
end
