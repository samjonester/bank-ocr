require 'account_formatter'
require 'account'

describe AccountFormatter do
  let(:account_number) {'123'}
  let(:account) {double(Account, account_number: account_number)}

  it "should print valid and legible account" do
    expect(account).to receive(:legible?).and_return(true)
    expect(account).to receive(:valid_checksum?).and_return(true)

    expect(subject.formatted_s(account)).to eq("#{account_number}")
  end

  it "should print an invalid account" do
    expect(account).to receive(:legible?).and_return(true)
    expect(account).to receive(:valid_checksum?).and_return(false)

    expect(subject.formatted_s(account)).to eq("#{account_number} ERR")
  end
 
  it "should print an illegible account" do
    expect(account).to receive(:legible?).and_return(false)

    expect(subject.formatted_s(account)).to eq("#{account_number} ILL")
  end
end
