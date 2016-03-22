require 'pry'
require 'ocr/file_reader'
require 'ocr/number_converter'

class OCR
  
  def initialize(file_reader: OCR::FileReader.new, 
                 number_converter: OCR::NumberConverter.new)
    @file_reader = file_reader
    @number_converter = number_converter
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

  def account_corrections(input)
    [].tap do |acc|
      (0..input.length).each do |i|
        acc.concat valid_substitutions(input, i) unless input[i] == "\n"
      end
    end.flatten
  end
 
  SUBSTITUTIONS = [' ', '|', '_']
  def substitution_chars(char)
    SUBSTITUTIONS.reject{|s| s == char}
  end

  def valid_substitutions(input, i)
    substitution_chars(input[i]).map do |sub_option|
      test_input = input.dup
      test_input[i] = sub_option
      read_account_number(test_input)
    end.select(&:valid_checksum?)
  end
end
