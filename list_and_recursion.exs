# 0

defmodule SumList do
    def of([]), do: 0
    def of([head]), do: head
    def of([head|[h_tail|tail]]), do: of([head + h_tail|tail])
end

# 1, 2, 3, 4, 5, 6, 7

defmodule MyList do
  def mapsum([], _func), do: 0
  def mapsum([head], func), do: func.(head)
  def mapsum([head|tail], func), do: func.(head) + mapsum(tail, func)

  def maxlist([head|tail]), do: maxlist([head|tail], 0)
  defp maxlist([], _max), do: []
  defp maxlist([head], max) when max > head, do: max
  defp maxlist([head], max) when max <= head, do: head
  defp maxlist([head|tail], max) when head > max, do: maxlist(tail, head)
  defp maxlist([head|tail], max) when head <= max, do: maxlist(tail, max)

  def caesar([], _n), do: []
  def caesar([head|tail], n) when head + n > 127, do: [rem((head + n), 127) + 32|caesar(tail, n)]
  def caesar([head|tail], n), do: [rem((head + n), 127)|caesar(tail, n)]

  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]

  def all?([], _func), do: true
  def all?([head|tail], func), do: func.(head) and all?(tail, func)

  def each([], _func), do: []
  def each([head|tail], func), do: [func.(head)|each(tail, func)]

  def filter([], _func), do: []
  def filter([head|tail], func) do
    if func.(head) do
      [head|filter(tail,func)]
    end
    [filter(tail, func)]
  end
end
