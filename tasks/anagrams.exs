defmodule Dictionary do
  @name __MODULE__

  ###
  # 外部API

  def start_link,
  do: Agent.start_link(fn -> %{} end, name: @name)

  def add_words(words),
  do: Agent.update(@name, &do_add_words(&1, words))

  def anagrams_of(words),
  do: Agent.get(@name, &Map.get(&1, signature_of(words)))

  ###
  # 内部実装

  defp do_add_words(map, words),
  do: Enum.reduce(words, map, &add_one_word(&1, &2))

  defp add_one_word(word, map),
  do: Map.update(map, signature_of(word), [word], &[word|&1])

  defp signature_of(word),
  do: word |> to_char_list |> Enum.sort |> to_string
end

defmodule WordlistLoader do
  def load_from_files(file_names) do
    file_names
    |> Stream.map(fn name -> Task.async(fn -> load_task(name) end) end)
    |> Enum.map(&Task.await/1)
  end

  def load_task(file_name) do
    File.stream!(file_name, [], :line)
    |> Enum.map(&String.strip/1)
    |> Dictionary.add_words
  end
end