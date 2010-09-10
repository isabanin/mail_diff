#
# Represent a single piece of a diff.
# 
class MailDiff::Chunk #:nodoc:
  attr_reader :diff, :meta_info, :content, :lines
  
  def initialize(diff, meta_info, content)
    @diff = diff
    @meta_info = meta_info
    @content = content
  end
  
  # Generate HTML presentation for a Chunk. Return a string.
  def to_html
    # We have to find lines before we can call line numbers methods.
    find_lines!
    generator.generate
  end
  
  # Return LineNumbers object that represents two columns of numbers
  # that will be displayed on the left of the HTML presentation.
  #
  # IMPORTANT! Before calling this method it's essential to call "find_lines!" first,
  # otherwise the array will be empty.
  def line_numbers
    @_line_numbers ||= MailDiff::LineNumbers.new(diff, meta_info)
  end
  
private

  def generator
    @_generator ||= MailDiff::ChunkGenerator.new(self)
  end

  # Parse the content searching for lines. Initialize Line object for every line.
  # Return an array of Line objects.
  def find_lines!
    @lines = []
    @lines.tap do
      content.split(/\r?\n/).each do |line_str|
        line = MailDiff::Line.new(diff, line_str)
        next if line.ignore?
        @lines << line
        line_numbers.act_on_line(line)
        line.left_number = line_numbers.left_column.last
        line.right_number = line_numbers.right_column.last
      end
    end
  end

end