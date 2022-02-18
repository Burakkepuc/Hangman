arr = ['a','c','d','f','a','a','b']

el = gets.chomp # =>a

arr.each_index do |i|
el[i]
end

arr.each_index do |i|
puts i if arr[i] == el
end

1. Find index of elements that repeating in an array.
