require_relative './module.rb'


some = [1,2,3]

# Tests

# # multiply_els
# puts 'multiply'

# # puts multiply_els(some)

# # my_each test

# puts 'Each'

# some.my_each { |x| puts x }

# some.my_each

# # my_each_with_index test

# puts 'Each with index'

# some.my_each_with_index { |x| puts x }

# puts some.my_each_with_index

# # my_select test

# puts 'Select'

# puts some.my_select { |a| a % 2 == 0 }

# puts some.my_select

# # my_all? test

# puts 'All'

# puts some.my_all? { |a| a % 2 == 0 }

# puts some.my_all? { |a| a % 1 == 0 }

# puts some.my_all?(/\D/)

# puts some.my_all?(/\d/)

# puts some.my_all?(String)

# # my_any? test

# puts 'Any'

# puts some.my_any? { |a| a % 2 == 0 }

# puts some.my_any?(/\d/)

# puts some.my_any?(String)

# # my_none? test

# puts 'None'

# puts some.my_none? { |a| a % 5 == 0 }

# puts some.my_none?(/\D/)

# puts some.my_none?(String)

# puts some.my_none?(Numeric)

# # my_count test

# puts 'Count'

# puts some.my_count(1)

# puts some.my_count

# puts (some.my_count { |a| a % 1 == 0 })

# # my_inject test

# puts 'Inject'

# puts (some.my_inject { |x, y| x * y })

puts 'with symbol'

puts some.my_inject(:+)

# puts some.my_inject(1) { |x, y| x + y }

# puts some.inject{|x,y| x*y}

# # Map with block and with proc

# puts 'Map'

# print some.my_map { |a| a * 2 }

# some_proc = Proc.new { |a| a * 2 }

# print some.my_map(&some_proc)

# puts some.my_map
