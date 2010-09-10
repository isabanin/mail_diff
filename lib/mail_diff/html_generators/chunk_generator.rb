class MailDiff::ChunkGenerator
  
  attr_reader :chunk
  
  def initialize(chunk)
    @chunk = chunk
  end
  
  def generate
    start_html +
    content +
    end_html
  end
  
private

  def content
    chunk.lines.map{|l| l.to_html }.join("\n")
  end

  def start_html
    %Q[<tr>]
  end
  
  def end_html
    %Q[</tr>]
  end
  
end