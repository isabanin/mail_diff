class MailDiff::ChunkGenerator
  
  attr_reader :chunk
  
  def initialize(chunk)
    @chunk = chunk
  end
  
  def generate
    content
  end
  
private

  def content
    chunk.lines.map{|l| l.to_html }.join("\n")
  end
  
end