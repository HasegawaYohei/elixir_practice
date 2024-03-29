defimpl Enumerable, for: Bitmap do
  import :match, only: [log: 1]

  def count(%Bitmap{value: value}) do
    { :ok, trunc(log(abs(value)) / log(2)) + 1 }
  end

  def member?(value, bit_number) do
    { :ok, 0 <= bit_number && bit_number < Enum.count(value) }
  end

  def reduce(bitmap, {:count, acc}, fun) do
    bit_count = Enum.count(bitmap)
    _reduce({bitmap, bit_count}, { :count, acc }, fun)
  end

  defp _reduce({_bitmap, -1}, { :count, acc }, _fun), do: { :done, acc }

  defp _reduce({bitmap, bit_number}, { :count, acc }, fun) do
    with bit = Bitmap.fetch_bit(bitmap, bit_number),
    do: _reduce({bitmap, bit_number - 1}, fun.(bit, acc), fun)
  end

  defp _reduce({_bitmap, _bit_number}, { :halt, acc }, _fun), do: { :halted, acc }

  defp _reduce({bitmap, bit_number}, { :suspend, acc }, fun),
  do: { :suspended, acc, &_reduce({bitmap, bit_number}, &1, fun), fun }
end

# fifty = %Bitmap(value: 50)
# IO.puts Enum.count fifty