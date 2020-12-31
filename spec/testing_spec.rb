require_relative '../lib/checks'

describe ErrorCheck do
  let(:checker) { ErrorCheck.new('test.rb') }

  describe '#tag_error' do
    it "Checks for missing/unexpected tags eg '( )', '[ ]', and '{ }'" do
      checker.tag_error
      expect(checker.errors[0]).to eql("line:15 Lint/Syntax: Unexpected/Missing token ')' Parenthesis")
    end
  end

  describe '#end_error' do
    it 'checks for missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]).to eql("Lint/Syntax: Missing 'end'")
    end
  end

  describe '#trailing_spaces' do
    it 'checks trailing space error on line 17 of test.rb' do
      checker.trailing_spaces
      expect(checker.errors[0]).to eql('line:17:9: Error: Trailing whitespace detected.')
    end
  end

  describe '#empty_line_error' do
    it 'checks empty line error on method' do
      checker.empty_line_error
      expect(checker.errors[0]).to eql('line:2 Extra empty line detected at the beginning of method')
    end
  end
end
