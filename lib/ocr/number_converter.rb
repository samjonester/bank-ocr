require 'ocr/account'

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

    def initialize(account: OCR::Account.new)
      @account = account
    end

    def convert_lines_to_numbers(account_lines)
      chunks_of_three = account_lines.map { |line| line.scan(/.{3}/) }
      acct_nums = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
      acct_nums.map { |num| NUMBERS.find_index(num) || '?'}
    end

    def identify_corrections(input)
      [].tap do |acc|
        (0..input.length).each do |i|
          acc.concat valid_substitutions(input, i) unless input[i] == "\n"
        end
      end.flatten
    end

    SUBSTITUTIONS = [' ', '|', '_']
    def substitution_chars(char)
      SUBSTITUTIONS.reject{|s| s == char}
    end

    def valid_substitutions(input, i)
      substitution_chars(input[i]).map do |sub_option|
        test_input = input.dup
        test_input[i] = sub_option
        convert_lines_to_numbers(test_input)
      end.select { |account_number| @account.valid_checksum?(account_number) }
    end
  end
end
