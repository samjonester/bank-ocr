require 'ocr'

describe OCR do
  describe 'reading account number' do
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
        account = subject.read_account_number test[:input]
        expect(account.account_number).to eq(test[:num])
      end
    end
  end

  describe 'finding corrections' do
    let(:input) { " _  _  _  _  _  _  _  _  _ \n"\
                  "|_||_||_||_||_||_||_||_||_|\n"\
                  "|_||_||_||_||_||_||_||_||_|" }
    let(:corrections) {[ '888886888', '888888880', '888888988' ]}


    it 'should produce a list of corrected account numbers' do
      expect(subject.account_corrections(input).map(&:account_number)).to eq(corrections)
    end
  end
end
