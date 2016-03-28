require 'ocr/account'
require 'ocr/character_substitutor'

class OCR
  class NumberConverter
    NUMBERS = [
      [' _ ',
       '| |',
       '|_|'],

      ['   ',
       '  |',
       '  |'],

      [' _ ',
       ' _|',
       '|_ '],

      [' _ ',
       ' _|',
       ' _|'],

      ['   ',
       '|_|',
       '  |'],

      [' _ ',
       '|_ ',
       ' _|'],

      [' _ ',
       '|_ ',
       '|_|'],

      [' _ ',
       '  |',
       '  |'],

      [' _ ',
       '|_|',
       '|_|'],

      [' _ ',
       '|_|',
       ' _|'],
    ]

    VALID_CHARACTERS = [' ', '|', '_']

    def initialize(account: OCR::Account.new, character_substitutor: OCR::CharacterSubstitutor.new(VALID_CHARACTERS))
      @account = account
      @character_substitutor = character_substitutor
    end

    def convert_lines_to_numbers(account_lines)
      chunks_of_three = account_lines.map { |line| line.scan(/.{3}/) }
      account_numbers = chunks_of_three[0].zip(chunks_of_three[1], chunks_of_three[2])
      account_numbers.map { |num| NUMBERS.find_index(num) || '?'}
    end

    def identify_corrections(account_lines)
      [].tap do |corrections|
        account_lines.each_with_index do |line, i|
          line.chars.each_with_index do |_, j|
            corrections.concat valid_corrections_at_position(account_lines, i, j)
          end
        end
      end
    end

    private
    def valid_corrections_at_position(account_lines, i, j)
      possible_corrections = @character_substitutor.possible_substitutions_at_position(account_lines, i, j)
      possible_account_numbers = possible_corrections.map { |correction| convert_lines_to_numbers(correction) }
      possible_account_numbers.select { |account_number| @account.valid_checksum?(account_number) }
    end
  end
end
