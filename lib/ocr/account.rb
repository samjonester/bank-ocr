class OCR
  class Account
    def checksum(acct_number)
      weighted = acct_number.reverse.each_with_index.map {|n, i| n*(i+1)}
      weighted.reduce(:+)
    end

    def legible?(acct_number)
      not acct_number.include?('?')
    end

    def valid_checksum?(acct_number)
      return false unless legible?(acct_number)

      checksum(acct_number) % 11 == 0
    end

  end
end
