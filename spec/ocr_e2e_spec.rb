require 'ocr'

describe OCR do
  context "End to End testing" do
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
      "000000000",
      "345882865",
      "664371495 ERR AMB 664371485",
      "?00000000 ILL"
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

      accounts = subject.read_account_numbers(file_path)
      subject.print_accounts accounts
    end
  end
end
