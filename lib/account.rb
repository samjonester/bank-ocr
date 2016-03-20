class Account
  def initialize(acct_number)
    @acct_number = acct_number
  end

  def account_number
    @acct_number.join
  end

  def to_s
    account_number
  end
end
