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
    acct_num_blocks = acct_row.map { |line| line.scan(/.{3}/) }
    acct_nums = acct_num_blocks[0].zip(acct_num_blocks[1], acct_num_blocks[2])
    acct_number = acct_nums.map { |num| NUMBERS.find_index(num) }

    Account.new acct_number
  end
end
