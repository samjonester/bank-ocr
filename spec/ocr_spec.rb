require 'ocr'

describe OCR do
  [
    input:  " _  _  _  _  _  _  _  _  _ \n"\
            "| || || || || || || || || |\n"\
            "|_||_||_||_||_||_||_||_||_|\n",
    num:    '000000000'
  ].each do |test|
    it "should produce an account number for #{test[:num]}" do
      expect(subject.read_line test[:input]).to eq(test[:num])
    end
  end
end
