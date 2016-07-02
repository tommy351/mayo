defmodule Mayo do
  defmacro validate(value, schema) do
    pipes = unpipe_schema(schema)
    Enum.reduce(pipes, value, &reduce_pipes/2)
  end

  defp unpipe_schema({op, _, _} = schema) when op == :|> do
    Macro.unpipe(schema)
  end

  defp unpipe_schema(schema) do
    [{schema, 0}]
  end

  defp reduce_pipes({{op, meta, args}, _}, acc) do
    pipe = {op, meta, [acc | args]}

    quote do
      case unquote(acc) do
        {:error, _} -> unquote(acc)
        _ -> unquote(pipe)
      end
    end
  end
end
