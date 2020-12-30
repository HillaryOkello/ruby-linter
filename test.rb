def my_each

  return to_enum(:my_each) unless block_given?

  i = 0
  while i < to_a.length
    yield(to_a[i])
    i += 1

  self
end

# 2.my_each_with_index
def my_each_with_index
  return to_enum :my_each_with_index) unless block_given?

  i = 0  
  my_each do |item|
    yield(item, i)
    i += 1
  end
  self


end



# def my_select
#   return to_enum(:my_select) unless block_given?

#   select_arr_result = []
#   each do |item|
#     select_arr_result << item if yield(item)
#   end
#   select_arr_result
# end