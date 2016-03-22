require 'ocr'
require 'ocr/file_reader'

describe OCR do
  let(:file_reader) { double(OCR::FileReader) }
  let(:number_converter) { double(OCR::NumberConverter) }

  describe 'reading account numbers' do
    let(:file_path) { '/foo/bar/fake/path' }
    let(:lines) { [['abc','def', 'ghi'], ['jkl','mno', 'pqr']] }
    let(:numbers) { [[1, 2, 3], [4, 5, 6]] }
    let(:corrections) { [['foo'], ['bar', 'baz']] }

    subject { OCR.new(file_reader: file_reader,
                     number_converter: number_converter) }

    before(:each) do
      expect(file_reader).to receive(:each_account_lines).with(file_path).and_return(lines)

      lines.each_with_index do |line, i|
        expect(number_converter).to receive(:convert_lines_to_numbers).with(line).and_return(numbers[i])
        expect(number_converter).to receive(:identify_corrections).with(line).and_return(corrections[i])
      end
    end

    it "should produce an account number" do
      accounts = subject.read_account_numbers  file_path

      expect(accounts.map{ |a| a[:account_number] }).to eq(numbers)
    end

    it "should identify corrections" do
      accounts = subject.read_account_numbers  file_path

      expect(accounts.map{ |a| a[:corrections] }).to eq(corrections)
    end

  end

  describe "End-to-End Functionality" do
    skip 'identifying corrections' do
      let(:input) { [ " _  _  _  _  _  _  _  _  _ ",
                      "|_||_||_||_||_||_||_||_||_|",
                      "|_||_||_||_||_||_||_||_||_|" ] }
      let(:corrections) {[ '888886888', '888888880', '888888988' ]}


      it 'should produce a list of corrected account numbers' do
        expect(subject.identify_corrections(input)).to eq(corrections)
      end
    end
  end
end
