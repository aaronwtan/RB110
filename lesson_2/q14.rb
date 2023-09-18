# Given this data structure write some code to return an array containing the colors of the fruits,
# and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

new_arr = hsh.map do |_, info|
  case info[:type]
  when 'fruit'     then info[:colors].map(&:capitalize)
  when 'vegetable' then info[:size].upcase
  end
end

# The return value should look like this:
p new_arr == [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
