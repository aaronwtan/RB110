# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones_hsh = {}

flintstones.each_with_index do |name, index|
  flintstones_hsh[name] = index
end

p flintstones_hsh
