describe 'Account' do
  it 'should have an account number' do
    subject = Account.new([1,2,3])

    expect(subject.account_number).to eq('123')
  end
end

