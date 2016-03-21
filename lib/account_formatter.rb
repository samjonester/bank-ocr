class AccountFormatter
  def formatted_s(account)
    "#{account.account_number}#{illegible_s(account) || error_s(account)}"
  end

  private
  def illegible_s(account)
    ' ILL' unless account.legible?
  end
  def error_s(account)
    ' ERR' unless account.valid_checksum?
  end
end
