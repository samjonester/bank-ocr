class OCR
  class NumberConverter
    NUMBERS = [
      [' _ ',
       '| |',
       '|_|'],

      ['   ',
       '  |',
       '  |'],

      [' _ ',
       ' _|',
       '|_ '],

      [' _ ',
       ' _|',
       ' _|'],

      ['   ',
       '|_|',
       '  |'],

      [' _ ',
       '|_ ',
       ' _|'],

      [' _ ',
       '|_ ',
       '|_|'],

      [' _ ',
       '  |',
       '  |'],

      [' _ ',
       '|_|',
       '|_|'],

      [' _ ',
       '|_|',
       ' _|'],
    ]

    def convert_lines_to_numbers(account_lines)
      chunks_of_three = account_lines.map { |line| line.scan(/.{3}/) }
      acct_nums = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
      acct_nums.map { |num| NUMBERS.find_index(num) || '?'}
    end
  end
end
