class Sentence

  def initialize(filename)
    raise ArgumentError unless filename.is_a? String
    File.open(filename, "r") do |f|
      @lines = f.readlines
    end
    @count = Hash.new(0)
  end

  def count_sentences
    @lines.each do |line|
      @count[line.strip] += 1
    end
    @count = @count.sort_by { |k, v| -v }.to_h
  end

  def output_file
    File.open("output", "w") do |f|
      @count.each do |k, v|
        f.puts "\t#{v}: #{k}"
      end
    end
  end

end

# a = Sentence.new("input")
# a.count_sentences
# a.output_file
