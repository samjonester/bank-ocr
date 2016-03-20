require 'ocr'

describe OCR do
  [
    {
      input:  " _  _  _  _  _  _  _  _  _ \n"\
              "| || || || || || || || || |\n"\
              "|_||_||_||_||_||_||_||_||_|",
      num:    '000000000'
    },
    {
      input:  "    _  _     _  _  _  _  _ \n"\
              "  | _| _||_||_ |_   ||_||_|\n"\
              "  ||_  _|  | _||_|  ||_| _|",
      num:    '123456789'
    },
    {
      input:  "    _  _     _  _  _  _  _ \n"\
              "___ _| _||_||_ |_   ||_||_|\n"\
              "||||_  _|  | _||_|  ||_| _|",
      num:    '?23456789'
    }
  ].each do |test|
    it "should produce an account number for #{test[:num]}" do
      account = subject.read_acct_number test[:input]
      expect(account.account_number).to eq(test[:num])
    end
  end
end
