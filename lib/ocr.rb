require 'ocr/file_reader'
require 'ocr/number_converter'
require 'ocr/account_formatter'

class OCR
  
  def initialize(file_reader: OCR::FileReader.new, 
                 number_converter: OCR::NumberConverter.new,
                 account_formatter: OCR::AccountFormatter.new)
    @file_reader = file_reader
    @number_converter = number_converter
    @account_formatter = account_formatter
  end

  def read_account_numbers(file_path)
    accounts = @file_reader.each_account_lines(file_path)
    accounts.map do |account|
      {
        account_number: @number_converter.convert_lines_to_numbers(account),
        corrections: @number_converter.identify_corrections(account)
      }
    end
  end

  def print_accounts(accounts)
    accounts.each do |account|
      puts @account_formatter.formatted_s(account[:account_number], account[:corrections])
    end
  end
end
