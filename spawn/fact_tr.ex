defmodule TailRecursive do
  def factorial(n),   do: _fact(n, 1)
  defp _fact(0, acc), do: acc
  defp _fact(, acc),  do: _fact(n-1, acc*n)
end
