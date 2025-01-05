# def check(n)
#   result = n * 3 + 1
#   while result != do
#     result = result.even? ? result /2 : check * 3 + 1
#     return true if result == n
#   end
#   return false
# end

# puts 

# def check(n, result = n * 3 + 1, count = 0)
#   return count if result == 1

#   count += 1 if result == n
#   result = result.even? ? result / 2 : result * 3 + 1
#   check(n, result, count)
# end

# puts check(2)
# puts check(10)

# def check(n, result, count = 0)
#   result = n * 3 + 1 if result == 0
#   return count if result == 1

#   count += 1 if result == n
#   result = result.even? ? result / 2 : result * 3 + 1
#   check(n, result, count)
# end

# puts check(2)
# puts check(10)

# def is_loop(n)
#   check = n * 3 + 1
#   while check != 1 do
#     check = check.even? ? check / 2 : check * 3 + 1
#     return true if check == n
#   end
#   return false
# end
# puts 2.step(10000, 2).count{|i|
#   is_loop(i)
# }

# def is_loop(n, check = nil)
#   check ||= n * 3 + 1

#   return false if check == 1
#   return true if check == n

#   check = check.even? ? check / 2 : check * 3 + 1
#   is_loop(n, check)
# end

# # puts 2.step(10000, 2).count { |i| is_loop(i) }
# count = 0
# (2..10000).each do |i|
#   count += 1 if i.even? && is_loop(i)
# end
# puts count

require 'date'
term = Date.parse('19641010')..Date.parse('20200724')
puts term
term_i = term.map{|d|d.strftime('%Y%m%d').to_i}
puts term_i.select{|d|d==d.to_s(2).reverse.to_i(2)}