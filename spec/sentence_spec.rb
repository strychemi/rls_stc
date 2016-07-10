require 'sentence'

describe Sentence do

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

    it 'raises no error if file exists within same directory' do
      allow(File).to receive(:open).and_return(File.open("output", "w"))
      expect{ Sentence.new("input") }.not_to raise_error
    end
  end

end
