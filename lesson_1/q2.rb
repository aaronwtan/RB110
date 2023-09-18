# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages_sum = ages.values.sum
p ages_sum

# using basic looping

total_ages = 0
age_values = ages.values
counter = 0

loop do
  break if counter >= ages.size

  total_ages += age_values[counter]
  counter += 1
end

p total_ages
