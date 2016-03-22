require 'ocr'

describe OCR do
  #             account_number: [6,6,4,3,7,1,4,9,5],
  let(:input) {
    " _  _  _  _  _  _  _  _  _ \n"\
    "| || || || || || || || || |\n"\
    "|_||_||_||_||_||_||_||_||_|\n\n"\
    " _     _  _  _  _  _  _  _ \n"\
    " _||_||_ |_||_| _||_||_ |_ \n"\
    " _|  | _||_||_||_ |_||_| _|\n\n"\
    " _  _     _  _        _  _ \n"\
    "|_ |_ |_| _|  |  ||_||_||_ \n"\
    "|_||_|  | _|  |  |  | _| _|\n\n"\
    "||| _  _  _  _  _  _  _  _ \n"\
    "|||| || || || || || || || |\n"\
    "||||_||_||_||_||_||_||_||_|\n\n"\
  }

  let(:formatted_accounts) {[
    "000000000\n"\
    "345882845\n"\
    "664371495 ERR\n"\
    "?00000000 ILL\n"\
  ]}

  let(:file_path) do
    file = Tempfile.new('ocr_accounts')
    file.write input
    file.close
    file.path
  end

  it "should print account numbers from a file" do
    formatted_accounts.each do |account|
      expect(subject).to receive(:puts).with(account)
    end

    subject.print_accounts subject.read_account_numbers(file_path)
  end
end
