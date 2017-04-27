#1

list_concat = fn a,b -> a ++ b end
sum = fn a,b,c -> a + b + c end
pair_tuple_to_list = fn {a,b} -> [a,b] end

#2

fizz_buzz = fn
    0,0,_ -> "FizzBuzz"
    0,_,_ -> "Fizz"
    _,0,_ -> "Buzz"
    _,_,c -> c
    end

#3

fizz_buzz_rem = fn n -> fizz_buzz.(rem(n,3),rem(n,5),n) end

IO.puts fizz_buzz_rem.(10)
IO.puts fizz_buzz_rem.(11)
IO.puts fizz_buzz_rem.(12)
IO.puts fizz_buzz_rem.(13)
IO.puts fizz_buzz_rem.(14)
IO.puts fizz_buzz_rem.(15)
IO.puts fizz_buzz_rem.(16)

#4

prefix = fn str -> fn str2 -> str <> str2 end end

#5

Enum.map [1,2,3,4], &(&1 + 2)
Enum.each [1,2,3,4], &(IO.inspect &1)
