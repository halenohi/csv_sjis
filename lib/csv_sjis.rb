require "csv_sjis/version"
require "csv"

module CSVSjis
  SJIS_NAME = 'Shift_JIS'

  class << self
    def open(file, mode = 'w', options = {})
      options = {
        encoding: SJIS_NAME,
        undef: :replace,
        invalid: :replace
      }.merge(options)

      file = File.open(file, mode, options)
      csv = CSV.new(file, encoding: options[:encoding])
      builder = Builder.new(csv, options[:encoding] == SJIS_NAME)

      yield(builder) if block_given?

      builder
    end
  end

  class Builder < Struct.new(:csv, :is_sjis)
    def <<(row)
      csv << row.map{ |col|
        col.is_a?(String) && is_sjis ? sjis_safe(col) : col
      }
    end

    alias_method :push, :<<

    def sjis_safe(str)
      [
        ["FF5E", "007E"], # wave-dash
        ["FF0D", "002D"], # full-width minus
        ["00A2", "FFE0"], # cent as currency
        ["00A3", "FFE1"], # lb(pound) as currency
        ["00AC", "FFE2"], # not in boolean algebra
        ["2014", "2015"], # hyphen
        ["2016", "2225"], # double vertical lines
      ].inject(str) do |s, (before, after)|
        s.gsub(
          before.to_i(16).chr('UTF-8'),
          after.to_i(16).chr('UTF-8'))
      end
    end

    def method_missing(method, *args, &block)
      csv.send(method, *args, &block)
    end
  end
end
