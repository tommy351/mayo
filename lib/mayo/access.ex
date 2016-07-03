defmodule Mayo.Access do
  def fetch(value, key) when is_map(value) do
    Map.fetch(value, key)
  end

  def fetch(value, key) when is_list(value) do
    Keyword.fetch(value, key) 
  end

  def get(value, key) when is_map(value) do
    Map.get(value, key)
  end

  def get(value, key) when is_list(value) do
    Keyword.get(value, key)
  end

  def put(value, key, new) when is_map(value) do
    Map.put(value, key, new)
  end

  def put(value, key, new) when is_list(value) do
    Keyword.put(value, key, new)
  end

  def delete(value, key) when is_map(value) do
    Map.delete(value, key)
  end

  def delete(value, key) when is_list(value) do
    Keyword.delete(value, key)
  end
end
