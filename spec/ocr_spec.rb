require 'ocr'
require 'ocr/file_reader'

describe OCR do
  describe 'reading account number' do
    [
      {
        input:  [[" _  _  _  _  _  _  _  _  _ ",
                  "| || || || || || || || || |",
                  "|_||_||_||_||_||_||_||_||_|"]],
        nums:    [[0,0,0,0,0,0,0,0,0]]
      },
      {
        input:  [["    _  _     _  _  _  _  _ ",
                  "  | _| _||_||_ |_   ||_||_|",
                  "  ||_  _|  | _||_|  ||_| _|"]],
        nums:    [[1,2,3,4,5,6,7,8,9]]
      },
      {
        input:  [["    _  _     _  _  _  _  _ ",
                  "___ _| _||_||_ |_   ||_||_|",
                  "||||_  _|  | _||_|  ||_| _|"]],
        nums:    [['?',2,3,4,5,6,7,8,9]]
      }
    ].each do |test|
      let(:file_path) { '/foo/bar/fake/path' }
      let(:file_reader) { double(OCR::FileReader) }
      subject { OCR.new(file_reader: file_reader) }

      it "should produce an account number for #{test[:nums]}" do
        expect(file_reader).to receive(:each_account_lines).with(file_path).and_return(test[:input])

        accounts = subject.read_account_numbers  file_path

        expect(accounts).to eq(test[:nums])
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
