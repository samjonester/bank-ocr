class OCR
  class FileReader
    def each_account_lines(file_path)
      File.read(file_path).each_line.map{|line| line.chomp}.each_slice(4).map{|slice| slice.take(3)}
    end
  end
end
