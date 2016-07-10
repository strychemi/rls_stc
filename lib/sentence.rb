class Sentence

  def initialize(filename)
    raise ArgumentError unless filename.is_a? String
    @input_file = File.open(filename, "r")
    @output_file = nil
  end
  
end
