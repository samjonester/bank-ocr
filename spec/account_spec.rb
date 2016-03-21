describe 'Account' do
  it 'should have an account number' do
    subject = Account.new([1,2,3])

    expect(subject.account_number).to eq('123')
  end

  [
    {
      account_number: [3,4,5,8,8,2,8,6,5],
      valid: true,
      legible: true
    },
    {
      account_number: [6,6,4,3,7,1,4,9,5],
      valid: false,
      legible: true
    },
    {
      account_number: ['?',2,3,4,5,6,7,8,9],
      valid: false,
      legible: false
    }
  ].each do |test|
    #
    # Valid is defined as being legible and also having a valid checksum
    #
    # account number:  3  4  5  8  8  2  8  6  5
    # position names:  d9 d8 d7 d6 d5 d4 d3 d2 d1
    #
    # checksum calculation:
    # checksum = (d1+2*d2+3*d3 +..+9*d9)
    # valid = checksom % 11 ==0
    it "account #{test[:account_number].join} should #{'not' unless test[:valid]} be a valid checksum" do
      subject = Account.new(test[:account_number])
      expect(subject.valid_checksum?).to eq(test[:valid])
    end

    # Legible is defined by an account without any unknown characters
    # Unknown characters are represented as ?
    it "account #{test[:account_number].join} should #{'not' unless test[:legible]} be legible" do
      subject = Account.new(test[:account_number])
      expect(subject.legible?).to eq(test[:legible])
    end

  end
end

