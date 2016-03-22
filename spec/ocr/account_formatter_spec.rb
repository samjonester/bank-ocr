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
end
