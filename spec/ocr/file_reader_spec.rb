require 'ocr/file_reader'

describe OCR::FileReader do
  let(:input) {"abc\n"\
               "def\n"\
               "ghi\n\n"\
               "123\n"\
               "456\n"\
               "789\n\n"}

  let(:file_path) do
    file = Tempfile.new('file_reader_spec')
    file.write(input)
    file.close
    file.path
  end

  it "should read lines" do
    expect(subject.each_account_lines(file_path)).to eq([["abc","def","ghi"],["123","456","789"]])
  end
end
