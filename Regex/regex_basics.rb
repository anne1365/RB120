arr = ['cat', 'scat', 'catalog', 'primary']

p arr.select { |word| word.match?(/cat/) }
