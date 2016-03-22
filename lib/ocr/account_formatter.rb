class OCR
  class AccountFormatter
    def initialize(account: OCR::Account.new)
      @account = account
    end

    def formatted_s(account_number, alternatives = [])
      "#{account_str(account_number)}#{illegible_s(account_number) || error_s(account_number)}#{alternatives_str(alternatives)}"
    end

    private
    def account_str(account_number)
      account_number.join
    end
    def illegible_s(account_number)
      ' ILL' unless @account.legible?(account_number)
    end
    def error_s(account_number)
      ' ERR' unless @account.valid_checksum?(account_number)
    end
    def alternatives_str(alternatives)
      " AMB #{alternatives.map{|alt| account_str(alt)}.join(' ')}" unless alternatives.empty?
    end
  end
end
