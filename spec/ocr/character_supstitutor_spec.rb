require 'ocr/character_substitutor'

describe OCR::CharacterSubstitutor do
  let(:valid_characters) {['a','b','c']}
  subject { OCR::CharacterSubstitutor.new(valid_characters) }

  let(:lines) {['aaa','aaa']}
  let(:i) {1}
  let(:j) {2}

  let(:expected_substitutions) {[['aaa','aab'],
                                 ['aaa','aac']]}

  it 'should find possibible substitutions' do
    possible_substitutions = subject.possible_substitutions_at_position(lines, i, j)
    expect(possible_substitutions).to eq(expected_substitutions)
  end
end
