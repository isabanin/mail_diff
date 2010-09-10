class MailDiff::DiffGenerator
  
  attr_reader :diff
  
  def initialize(diff)
    @diff = diff
  end
  
  def generate
    chunks_html = diff.chunks.map{|c| c.to_html}.join(chunk_separator_html).to_s
    intro_html + chunks_html + outro_html
  end

private

  def intro_html
    %Q[<div style="padding: 0 0 1em; overflow:auto; overflow-y: hidden;">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F9F9F9" style="margin: 0; border: 1px solid #E5E5E5; border-collapse: collapse; padding: 0; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;">]
  end
  
  def chunk_separator_html
%Q[<tr>
	<td bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 1em;">&nbsp;</td>
	<td bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 1em;">&nbsp;</td>
	<td style="padding: .3em 1em;">&nbsp;</td>
</tr>
<tr>
	<td colspan="3" height="2" bgcolor="#E5E5E5"></td>
</tr>
<tr>
	<td bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 1em;">&nbsp;</td>
	<td bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 1em;">&nbsp;</td>
	<td style="padding: .3em 1em;">&nbsp;</td>
</tr>]
  end
  
  def outro_html
    %Q[</table></div>]
  end
  
end