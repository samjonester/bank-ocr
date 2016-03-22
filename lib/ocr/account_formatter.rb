class OCR
  class AccountFormatter
    def initialize(account: OCR::Account.new)
      @account = account
    end

    def formatted_s(account_number)
      "#{account_number.join}#{illegible_s(account_number) || error_s(account_number)}"
    end

    private
    def illegible_s(account_number)
      ' ILL' unless @account.legible?(account_number)
    end
    def error_s(account_number)
      ' ERR' unless @account.valid_checksum?(account_number)
    end
  end
end
