def cutbar(m, n, current)
  if current >= n then
    0
  elsif current < m then
    1 + cutbar(m, n, current * 2)
  else
    1 + cutbar(m, n, current + m)
  end
end
puts cutbar(3, 20, 1)

current += current < m ? current : m

if current < m
  current += current
else
  current += m
end
