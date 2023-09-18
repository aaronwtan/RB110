# Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# basic looping
age_values = ages.values
min_age = age_values[0]
counter = 0

loop do
  break if counter >= ages.size

  current_age = age_values[counter]
  min_age = current_age if current_age < min_age
  counter += 1
end

p min_age

# idiomatic
p ages.values.min
