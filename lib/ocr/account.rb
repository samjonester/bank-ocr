class OCR
  class Account
    def checksum(account_number)
      weighted = account_number.reverse.each_with_index.map {|n, i| n*(i+1)}
      weighted.reduce(:+)
    end

    def legible?(account_number)
      not account_number.include?('?')
    end

    def valid_checksum?(account_number)
      return false unless legible?(account_number)

      checksum(account_number) % 11 == 0
    end

  end
end
