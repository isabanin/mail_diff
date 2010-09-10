class MailDiff::LineGenerator
  
  attr_reader :line
  
  def initialize(line)
    @line = line
  end
  
  def generate
    if line.added?
      added_html
    elsif line.deleted?
      deleted_html
    else
      not_modified_html
    end
  end
  
private

  def wrapper(&block)
    line_start +
    line_numbers +
    yield +
    line_end
  end
  
  def line_start
    %Q[<tr>]
  end
  
  def line_end
    %Q[</tr>]
  end
  
  def line_numbers
    %Q[<td width="2%" align="right" valign="top" bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 0; color: #BBB;">
<pre style="margin: 0; border: 0; padding: 0; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;">#{ line.left_number }</pre>
	  </td>
	  <td width="2%" align="right" valign="top" bgcolor="#F3F3F3" style="border-right: 1px solid #E5E5E5; padding: .3em 0; color: #BBB;">
<pre style="margin: 0; border: 0; padding: 0; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;">#{ line.right_number }</pre>
    </td>]
  end
  
  def added_html
    wrapper do
      %Q[<td valign="top" style="padding: .3em 1em;">
<pre style="margin: 0; border: 0; padding: 0; white-space: pre-wrap; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;"><span class="gd">#{ line.format }</span></pre>
      </td>]
    end
  end

  def deleted_html
    wrapper do
      %Q[<td valign="top" style="padding: .3em 1em;">
<pre style="margin: 0; border: 0; padding: 0; white-space: pre-wrap; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;"><span class="gi">#{ line.format }</span></pre>
      </td>]
    end
  end

  def not_modified_html
    wrapper do
      %Q[<td valign="top" style="padding: .3em 1em;">
<pre style="margin: 0; border: 0; padding: 0; white-space: pre-wrap; font: 11px Monaco, 'Lucida Console', Consolas, 'Courier New', monospace;">#{ line.format }</pre>
		  </td>]
		end
  end
  
end