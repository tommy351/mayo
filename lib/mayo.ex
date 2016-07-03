defmodule Mayo do
  @doc """
  Validates data with a schema.

      iex> Mayo.validate "test", Mayo.String.min(4) |> String.capitalize
      "Test"

      iex> Mayo.validate 42, Mayo.Number.max(23)
      {:error, %Mayo.Error{type: "number.max"}}
  """
  defmacro validate(value, schema) do
    compile(schema, value)
  end

  defp compile(schema, value) do
    [{h, _} | tail] = unpipe_schema(schema)
    Enum.reduce(tail, compile_pipe(h, value), &reduce_pipes/2)
  end

  defp unpipe_schema({op, _, _} = schema) when op == :|> do
    Macro.unpipe(schema)
  end

  defp unpipe_schema(schema) do
    [{schema, 0}]
  end

  defp reduce_pipes({pipe, _}, acc) do
    pipe = compile_pipe(pipe, quote do: result)

    quote do
      case unquote(acc) do
        {:error, _} = err -> err
        result -> unquote(pipe)
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
    item = quote do: Map.get(result, unquote(key))
    pipe = compile(pipes, item)

    quote do
      case unquote(acc) do
        {:error, _} = err -> err

        result ->
          case unquote(pipe) do
            value when is_nil(value) ->
              result

            {:error, %Mayo.Error{paths: paths} = err} ->
              {:error, %{err | paths: [unquote(key) | paths]}}

            value ->
              Map.put(result, unquote(key), value)
          end
      end
    end
  end
end
