require 'ocr/number_converter'

describe OCR::NumberConverter do
  [
    {
      input:  [" _  _  _  _  _  _  _  _  _ ",
               "| || || || || || || || || |",
               "|_||_||_||_||_||_||_||_||_|"],
      nums:    [0,0,0,0,0,0,0,0,0]
    },
    {
      input:  ["    _  _     _  _  _  _  _ ",
               "  | _| _||_||_ |_   ||_||_|",
               "  ||_  _|  | _||_|  ||_| _|"],
      nums:    [1,2,3,4,5,6,7,8,9]
    },
    {
      input:  ["    _  _     _  _  _  _  _ ",
               "___ _| _||_||_ |_   ||_||_|",
               "||||_  _|  | _||_|  ||_| _|"],
      nums:    ['?',2,3,4,5,6,7,8,9]
    }
  ].each do |test|
    it "should prouduce a number for #{test[:nums].flatten}" do
      converted_numbers = subject.convert_lines_to_numbers(test[:input])
      expect(converted_numbers).to eq(test[:nums])
    end
  end

  describe 'identifying corrections' do
    let(:account) { double(OCR::Account) }
    let(:account_number) { [ " _  _  _  _  _  _  _  _  _ ",
                             "|_||_||_||_||_||_||_||_||_|",
                             "|_||_||_||_||_||_||_||_||_|" ] }
    let(:corrections) {[ '888886888', '888888880', '888888988' ]}

    before(:each) do
      expect(account).to receive(:valid_checksum?).at_least(:once) do |account_number|
        corrections.include?(account_number.join)
      end
    end
    subject {OCR::NumberConverter.new(account: account) }

    it 'should find valid corrections' do
      expect(subject.identify_corrections(account_number).map{|c| c.join}).to eq(corrections)
    end
  end

end
