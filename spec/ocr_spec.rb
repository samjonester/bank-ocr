require 'ocr'
require 'ocr/file_reader'

describe OCR do
  let(:file_reader) { double(OCR::FileReader) }
  let(:number_converter) { double(OCR::NumberConverter) }

  describe 'reading account number' do
    let(:file_path) { '/foo/bar/fake/path' }
    let(:lines) { [['abc','def', 'ghi'], ['jkl','mno', 'pqr']] }

    subject { OCR.new(file_reader: file_reader,
                     number_converter: number_converter) }

    before(:each) do
      expect(file_reader).to receive(:each_account_lines).with(file_path).and_return(lines)
      lines.each do |line|
        expect(number_converter).to receive(:convert_lines_to_numbers).with(line).and_return(line)
      end
    end

    it "should produce an account number" do
      accounts = subject.read_account_numbers  file_path

      expect(accounts).to eq(lines)
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
