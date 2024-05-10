=begin
Input: string
output: new string

Rules: swap the positions of alphabetic characters and numeric characters.

From looking at examples, seems to follow this logic:
  - if the digit is alphabetic, look for the next numeric and vice versa
  - switch their positions
  - "freeze" them there - they can no longer be swapped by future elements
  - if there is no corresponding alphabetic/numeric character ahead, do not swap

Questions:
Do I ignore/preserve non-alphanumeric chars? Assuming so
Do I preserve case? Assuming so
English alphabet a-zA-Z? Assuming so.
Should I consider any compound values like -1, 1.5, or NaN as single numbers?
Assuming not due to the phrase "numeric character", which I take to mean digit 0-9.

Data Structure:
I think leaving the input as a string makes sense. We could make it an array as well; either way, we're just walking through indices.
We can also have the output be a string that we build up, filling in spaces over time, but I think an  array that starts sparse and fills in makes more sense.

Algorithm:
Create an empty result array
iterate over the string swapping chars, adding swapped pairs to the array
  - skip if the array already has a value at that index
  - for each character:
    - if it's alphabetic,
      - iterate through indices from that point, looking for a number
        - skip if the array already has a value at that index
        - if we find a number, add the number to the result array at the position of the letter, add the letter to the result array at the position of the number
        - if not, just add the letter to the result array at its position
    - if it's numeric,
      - do the same thing, looking for a letter
    - if it's neither, just add it to the result array at its current position
join & return the array

New approach
create a result string and build it up

get all the letters in an array
get all the digits in an array

iterate over the string
  - if it's a letter, shift out the first digit and add to result
    - if there are no digits left in the array, add the letter
  - if it's a digit, vice versa
  - if it's neither letter nor digit, add it to the array
=end