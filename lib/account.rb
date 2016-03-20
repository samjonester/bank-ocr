class Account
  def initialize(acct_number)
    @acct_number = acct_number
  end

  def to_s
    @acct_number.join
  end
end
