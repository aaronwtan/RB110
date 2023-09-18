# Consider this nested Hash:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# Determine the total age of just the male members of the family.
# male_munsters = munsters.select { |name, info| info['gender'] == 'male' }
# male_ages = male_munsters.map { |name, info| info['age'] }
# total_age = male_ages.reduce(:+)
# p total_age

# total_male_age = 0

# munsters.each do |name, info|
#   total_male_age += info['age'] if info['gender'] == 'male'
# end

# p total_male_age

total_male_age = 0

munsters.each_value do |info|
  total_male_age += info['age'] if info['gender'] == 'male'
end

p total_male_age
