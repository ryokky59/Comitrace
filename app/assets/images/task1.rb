#10未満の自然数のうち、3もしくは5の倍数になっているものは3, 5, 6, 9の4つがあり, これらの合計は 23 になる。
#同じようにして、1000 未満の 3 か 5 の倍数になっている数字の合計を求めよ。

sum = 0

for i in 1..999 do
  if i % 3 == 0 || i % 5 == 0
    sum += i
    p sum #途中の計算結果が見たかったため追記
  end
end

p "合計は#{sum}です"
