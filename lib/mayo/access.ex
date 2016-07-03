defprotocol Mayo.Access do
  def fetch(value, key)
  def get(value, key)
  def put(value, key, new)
  def delete(value, key)
  def keys(value)
end

defimpl Mayo.Access, for: Map do
  defdelegate fetch(value, key), to: Map
  defdelegate get(value, key), to: Map
  defdelegate put(value, key, new), to: Map
  defdelegate delete(value, key), to: Map
  defdelegate keys(value), to: Map
end

defimpl Mayo.Access, for: List do
  defdelegate fetch(value, key), to: Keyword
  defdelegate get(value, key), to: Keyword
  defdelegate put(value, key, new), to: Keyword
  defdelegate delete(value, key), to: Keyword
  defdelegate keys(value), to: Keyword
end
