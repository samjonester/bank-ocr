require 'account'

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

  def read_acct_number(input)
    acct_row = input.split(/\n/).take(3)
    chunks_of_three = acct_row.map { |line| line.scan(/.{3}/) }
    acct_nums = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
    acct_number = acct_nums.map { |num| NUMBERS.find_index(num) || '?'}

    Account.new acct_number
  end
end
