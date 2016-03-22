require 'ocr'
require 'ocr/file_reader'
require 'ocr/account_formatter'

describe OCR do
  let(:file_reader) { double(OCR::FileReader) }
  let(:number_converter) { double(OCR::NumberConverter) }
  let(:account_formatter) { double(OCR::AccountFormatter) }

    subject { OCR.new(file_reader: file_reader,
                     number_converter: number_converter,
                     account_formatter: account_formatter) }


  describe 'reading account numbers' do
    let(:file_path) { '/foo/bar/fake/path' }
    let(:lines) { [['abc','def', 'ghi'], ['jkl','mno', 'pqr']] }
    let(:numbers) { [[1, 2, 3], [4, 5, 6]] }
    let(:corrections) { [['foo'], ['bar', 'baz']] }
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


  describe 'printing account numbers' do
    let(:accounts) {[
      { account_number: [1,2,3],
        corrections: [ [4,5,6] ]
      }
    ]}

    before(:each) do
      expect(account_formatter).to receive(:formatted_s).with([1,2,3], [[4,5,6]]).and_return('hello world')
    end

    it 'should print formatted account info' do
      expect(subject).to receive(:puts).with('hello world')
      subject.print_accounts(accounts)
    end
  end

end
