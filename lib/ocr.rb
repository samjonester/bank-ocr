require 'pry'
require 'ocr/account'

class OCR
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

  def read_account_number(input)
    acct_row = input.split(/\n/).take(3)
    chunks_of_three = acct_row.map { |line| line.scan(/.{3}/) }
    acct_nums = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
    acct_number = acct_nums.map { |num| NUMBERS.find_index(num) || '?'}

    OCR::Account.new acct_number
  end

  def account_corrections(input)
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
      read_account_number(test_input)
    end.select(&:valid_checksum?)
  end

end
