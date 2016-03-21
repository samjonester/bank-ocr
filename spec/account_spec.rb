describe 'Account' do
  it 'should have an account number' do
    subject = Account.new([1,2,3])

    expect(subject.account_number).to eq('123')
  end

  [
    {
      account_number: [3,4,5,8,8,2,8,6,5],
      valid: true,
      legible: true,
      string: '345882865'
    },
    {
      account_number: [4,5,7,5,0,8,0,0,0],
      valid: true,
      legible: true,
      string: '457508000'
    },
    {
      account_number: [6,6,4,3,7,1,4,9,5],
      valid: false,
      legible: true,
      string: '664371495 ERR'
    },
    {
      account_number: ['?',2,3,4,5,6,7,8,9],
      valid: false,
      legible: false,
      string: '?23456789 ILL'
    }
  ].each do |test|
    it "should #{'not' unless test[:valid]} be valid: account #{test[:account_number].join}" do
      subject = Account.new(test[:account_number])
      expect(subject.valid?).to eq(test[:valid])
    end

    it "should #{'not' unless test[:legible]} be legible: account #{test[:account_number].join}" do
      subject = Account.new(test[:account_number])
      expect(subject.legible?).to eq(test[:legible])
    end

    it "should represent checksum and legibility in formatted_s: account #{test[:account_number].join}" do
      subject = Account.new(test[:account_number])
      expect(subject.formatted_s).to eq(test[:string])
    end
  end
end

