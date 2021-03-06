require 'cgi'

#
# Main class to interact with. In fact this is the only class you should interact with
# when using the library.
# 
# === Usage example
#  mail_diff = MailDiff::Diff.new(udiff)
#  mail_diff.to_html
#
# Keep in mind that Diff will automatically escape all HTML tags from the intput string
# so that it doesn't interfere with the output.
#
class MailDiff::Diff
  CHUNK_REGEXP = /^@@ .+ @@\n?/

  attr_reader :input, :options

  # Create new Diff object.
  # Accept a String in unified diff format and options hash.
  def initialize(unified_diff, options={})
    @input = escape_html(unified_diff)
    @options = options
  end

  # Generate HTML presentation. Return a string.
  def to_html    
    generator.generate
  end
  
  # Return an array of Chunk objects that Diff found in the input.
  def chunks
    @_chunks ||= find_chunks(input)
  end

private

  def generator
    @_generator ||= MailDiff::DiffGenerator.new(self)
  end

  # Parse the input for diff chunks and initialize a Chunk object for each of them.
  # Return an array of Chunks.
  def find_chunks(text)
    meta_info = text.scan(CHUNK_REGEXP)
    chunks = []
    chunks.tap do
      split = text.split(CHUNK_REGEXP)
      split.shift
      split.each_with_index do |lines, idx|        
        chunks << MailDiff::Chunk.new(self, meta_info[idx], lines)
      end
    end
  end
  
  def escape_html(input_text)
    CGI.escapeHTML(input_text)
  end

end