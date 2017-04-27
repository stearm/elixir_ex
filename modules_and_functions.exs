#1,2,3

defmodule Times do
    def double(n), do: n * 2
    def triple(n), do: n * 3
    def quadruple(n), do: 2 * double(n)
end

#4

defmodule Sum do
    def of(0), do: 0
    def of(n), do: n + of(n - 1)
end

#5

defmodule Gcd do
  def of(x,0), do: x
  def of(x,y), do: of(y,rem(x,y))
end

#6

defmodule Chop do
  def guess(first..last, number) when number > 0, do: guess(first..last,div(last,2),number)

  def guess(_.._, guessed, number) when guessed === number do
    IO.puts "Is it #{number}"
    number
  end

  def guess(first..last, guessed, number) when guessed > number do
    IO.puts "Is it #{guessed}"
    guess(first..guessed - 1, div(first + guessed - 1, 2), number)
  end

  def guess(first..last, guessed, number) when guessed < number do
    IO.puts "Is it #{guessed}"
    guess(guessed + 1..last, div(guessed + 1 + last, 2), number)
  end
end

