module MailDiff #:nodoc:
end

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require_local 'mail_diff/diff'
require_local 'mail_diff/chunk'
require_local 'mail_diff/line_numbers'
require_local 'mail_diff/line'

require_local 'mail_diff/html_generators/diff_generator'
require_local 'mail_diff/html_generators/chunk_generator'
require_local 'mail_diff/html_generators/line_generator'