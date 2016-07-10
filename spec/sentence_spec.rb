require 'sentence'

describe Sentence do
  let(:test_file_path) { File.dirname(__FILE__) + '/fixtures/test_input' }
  let(:object) { Sentence.new(test_file_path) }

  describe '#initialize' do
    it 'raises an ArgumentError with 0 arguments' do
      expect{ Sentence.new }.to raise_error ArgumentError
    end

    it 'raises error when passing more than 1 arguments' do
      expect{ Sentence.new("one", "two") }.to raise_error ArgumentError
    end

    it 'raises error when passing a nonstring as argument' do
      expect{ Sentence.new(1) }.to raise_error ArgumentError
    end

    it 'raises a SystemCallError when filename cannot be found' do
      expect{ Sentence.new("nonexistfile.txt") }.to raise_error SystemCallError
    end

    it 'it reads the file if file exists within same directory' do
      expect( object.instance_variable_get(:@lines) ).to be_kind_of(Array)
    end
  end

  describe '#count_sentences' do

    it 'returns a hash' do
      expect(object.count_sentences).to be_kind_of(Hash)
    end

    it '@count is populated for an appropriate input' do
      object.count_sentences
      actual = object.instance_variable_get(:@count)
      expected = {"I like dogs." => 2, "I like cats." => 1}
      expect(actual).to eq(expected)
    end

    it '@count is an empty hash for a file with no lines' do
      empty_file_path = File.dirname(__FILE__) + '/fixtures/empty_input'
      object = Sentence.new(empty_file_path)
      object.count_sentences
      actual = object.instance_variable_get(:@count)
      expect(actual).to eq({})
    end
  end

  describe '#output_file' do
    it '#open is called for output file' do
      object.count_sentences
      file = double(File)
      expect(File).to receive(:open).with("output", "w").and_yield(file)
      expect(file).to receive(:puts).exactly(2).times
      object.output_file
    end
  end
end
