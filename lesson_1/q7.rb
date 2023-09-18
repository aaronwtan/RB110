# Create a hash that expresses the frequency with which each letter occurs in this string:
statement = "The Flintstones Rock"
# ex:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# frequencies = statement.chars.tally

# p frequencies

ALPHABET = ('A'..'Z').to_a + ('a'..'z').to_a
frequencies = {}

statement.each_char do |char|
  if ALPHABET.include?(char)
    if frequencies.key?(char)
      frequencies[char] += 1 
    else
      frequencies[char] = 1
    end
  end
end

p frequencies
