# select example
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
p numbers
# Select (filter) only even numbers
even_numbers = numbers.select { |number| number.even?  } # juft sonlar

p even_numbers