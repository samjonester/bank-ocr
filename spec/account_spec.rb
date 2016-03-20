describe 'Account' do
  it 'should have an account number' do
    subject = Account.new([1,2,3])

    expect(subject.account_number).to eq('123')
  end

  [
    {
      account_number: [3,4,5,8,8,2,8,6,5],
      valid: true,
      string: '345882865'
    },
    {
      account_number: [4,5,7,5,0,8,0,0,0],
      valid: true,
      string: '457508000'
    },
    {
      account_number: [6,6,4,3,7,1,4,9,5],
      valid: false,
      string: '664371495 ERR'
    }
  ].each do |test|
    it "should #{'not' unless test[:valid]} have a valid checksum" do
      subject = Account.new(test[:account_number])
      expect(subject.valid?).to eq(test[:valid])
    end

    it "should represent checksum in to_s" do
      subject = Account.new(test[:account_number])
      expect(subject.to_s).to eq(test[:string])
    end
  end
end

