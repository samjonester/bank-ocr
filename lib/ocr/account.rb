class OCR
  class Account
    def initialize(acct_number)
      @acct_number = acct_number
    end

    def account_number
      @acct_number.join
    end

    def checksum
      weighted = @acct_number.reverse.each_with_index.map {|n, i| n*(i+1)}
      weighted.reduce(:+)
    end

    def legible?
      not @acct_number.include?('?')
    end

    def valid_checksum?
      return false unless legible?

      checksum % 11 == 0
    end

  end
end
