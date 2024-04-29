def closest_numbers(nums)
  result = []
  min_difference = nums.max - nums.min

  max_first_num_index = nums.size - 2

  (0..max_first_num_index).each do |first_num_index|
    max_second_num_index = nums.size - 1

    (first_num_index + 1..max_second_num_index).each do |second_num_index|
      first_num = nums[first_num_index]
      second_num = nums[second_num_index]

      current_nums = [first_num, second_num]
      current_difference = (first_num - second_num).abs

      if current_difference < min_difference
        min_difference = current_difference
        result = current_nums
      end
    end
  end

  result
end

p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 22, 7, 17]) == [12, 7]