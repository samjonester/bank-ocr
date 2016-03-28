class OCR
  class CharacterSubstitutor
    def initialize(valid_characters)
      @valid_characters = valid_characters
    end
    def possible_substitutions_at_position(lines, i, j)
      possible_chars_for_position = substitution_chars(lines[i][j])
      possible_chars_for_position.map do |substitution_option|
        substitute_at_position(lines, substitution_option, i, j)
      end
    end

    private
    def substitute_at_position(account_lines, substitution_option, i, j)
      account_lines_copy = account_lines.map { |a| a.dup }
      account_lines_copy[i][j] = substitution_option
      account_lines_copy
    end

    def substitution_chars(char)
      @valid_characters.reject{|s| s == char}
    end


  end
end
