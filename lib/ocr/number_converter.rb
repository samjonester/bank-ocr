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
      account_numbers = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
      account_numbers.map { |num| NUMBERS.find_index(num) || '?'}
    end

    def identify_corrections(input)
      [].tap do |acc|
        (0..input.length-1).each do |i|
          (0..input[i].length-1).each do |j|
            acc.concat valid_substitutions(input, i, j)
          end
        end
      end
    end

    private 
    def valid_substitutions(input, i, j)
      substitution_chars(input[i][j]).map do |sub_option|
        test_input = input.map { |a| a.dup }
        test_input[i][j] = sub_option
        convert_lines_to_numbers(test_input)
      end.select do |account_number| 
        @account.valid_checksum?(account_number) 
      end
    end

    SUBSTITUTIONS = [' ', '|', '_']
    def substitution_chars(char)
      SUBSTITUTIONS.reject{|s| s == char}
    end

  end
end
