require "byebug"

def range(start,ending)
  return [] if ending < start
  result_arr = [start+1]
  return result_arr if result_arr.last == ending-1
  result_arr + range(start+1,ending)
end

range(1,5)

def recursive_sum(array)
  array.first + range(array.first,array.last).reduce(:+) + array.last
end

recursive_sum([1,2,3,4,5])

def iterative_sum(array)
  array.reduce(:+)
end

def recursion_one(base, exp)
  return 1 if exp == 0
  puts base * recursion_one(base, exp - 1)
end

def recursion_two(base, exp)
  return 1 if exp == 0
  return base if exp == 1

  if exp.even?
    p recursion_two(base, exp / 2) ** 2
  else
    p base * (recursion_two(base, (exp - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    new_array = []
    self.each do |val|
      if val.is_a?(Array)
        new_array << val.deep_dup
      else
        new_array << val
      end
    end
    new_array
  end
end

def fib_it(n)
  result = [1, 1]
  return 1 if n == 0

  i = 0
  until result.length == n
    result << result[i, 2].reduce(:+)
    i += 1
  end

  result
end

def fib_recur(n)
  return [0,1].take(n) if n <= 2

  fib_array = fib_recur(n - 1)
  fib_array << fib_array[-2] + fib_array[-1]
end

def subsets(arr)
  return [[]] if arr.empty?
  return [[],[arr.first]] if arr.length == 1

  subsets_less_one = subsets(arr[0...-1]) # given subsets passing in [1,2] => [[1],[2],[1,2],[2,1]]
  result = []
  subsets_less_one.each do |set|
    result << set
    result << set + [arr.last]
  end
  result
end

def permutations(array)
  return [array, array.reverse] if array.length == 2

  subset = permutations(array[0...-1])
  results_array = []
  subset.each do |set|
    (0..set.length).each do |i|
      if i == 0
        results_array << [array.last] + set
      elsif i == set.length
        results_array << set + [array.last]
      else
        results_array << set[0...i] + [array.last] + set[i..-1]
      end
    end
  end

  results_array
end

# def binary_search(array, target)
#   debugger
#   return nil if array.size == 1
#
#   dup_array = array
#   middle_point = dup_array[dup_array.length/2]
#   left = 0
#   if middle_point < target
#
#     left += dup_array[0...(dup_array.length/2)].length
#     dup_array = dup_array[(dup_array.length/2)..-1]
#
#   elsif middle_point > target
#     # left += dup_array[(dup_array.length/2)..-1].length
#     dup_array = dup_array[0...dup_array.length/2]
#
#   else
#     return left
#   end
#
#   binary_search(dup_array, target)
# end

def binary_search(array, target)
  return nil if array.empty?

  middle_idx = array.length/2

  case target <=> array[middle_idx]

  when -1
    binary_search(array.take(middle_idx), target)
  when 0
    return middle_idx
  when 1
    binary_search(array[middle_idx..-1], target)
  end

end
