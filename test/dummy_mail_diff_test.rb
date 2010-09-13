require File.join(File.dirname(__FILE__), '..', 'lib', 'mail_diff')

file = File.read("example.udiff")
diff = MailDiff::Diff.new(file)

File.open("test_result.html", 'w') do |f|
  f << File.read("stylesheet.css")
  f << diff.to_html
end

`open test_result.html`
