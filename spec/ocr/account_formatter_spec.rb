require 'ocr/account_formatter'
require 'ocr/account'

describe OCR::AccountFormatter do
  let(:account_number) { [1,2,3] }
  let(:account_number_str) { '123' }
  let(:account) {double(OCR::Account)}

  subject { OCR::AccountFormatter.new(account: account) }

  it "should print valid and legible account" do
    expect(account).to receive(:legible?).with(account_number).and_return(true)
    expect(account).to receive(:valid_checksum?).with(account_number).and_return(true)

    expect(subject.formatted_s(account_number)).to eq("#{account_number_str}")
  end

  it "should print an invalid account" do
    expect(account).to receive(:legible?).with(account_number).and_return(true)
    expect(account).to receive(:valid_checksum?).with(account_number).and_return(false)

    expect(subject.formatted_s(account_number)).to eq("#{account_number_str} ERR")
  end
 
  it "should print an illegible account" do
    expect(account).to receive(:legible?).with(account_number).and_return(false)

    expect(subject.formatted_s(account_number)).to eq("#{account_number_str} ILL")
  end
 
  let(:correction_1) { [4,5,6] }
  let(:correction_1_str) { '456' }

  let(:correction_2) { [7,8,9] }
  let(:correction_2_str) { '789' }
  it "should print an ambigious account" do
    expect(account).to receive(:legible?).with(account_number).and_return(true)
    expect(account).to receive(:valid_checksum?).with(account_number).and_return(true)

    expect(subject.formatted_s(account_number, [correction_1, correction_2])).to eq("#{account_number_str} AMB #{correction_1_str} #{correction_2_str}")
  end

end
