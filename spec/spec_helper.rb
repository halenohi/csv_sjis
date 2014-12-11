require 'csv_sjis'

RSpec.configure do |config|
  config.add_setting :spec_root, default: Pathname.new(File.dirname(__FILE__))
end
