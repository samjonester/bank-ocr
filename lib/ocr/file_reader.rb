class OCR
  class FileReader
    def each_account_lines(file_path)
      lines = File.read(file_path).each_line
      lines_without_breaks = lines.map{|line| line.chomp}
      lines_without_breaks.each_slice(4).map{|slice| slice.take(3)}
    end
  end
end
