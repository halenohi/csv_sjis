# CSVSjis

This can safely save the csv for Excel in Japanese(Shift_JIS)

## Installation

Add this line to your application's Gemfile:

    gem 'csv_sjis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_sjis

## Usage

```
file_path = Pathname.new(File.dirname(__FILE__) + '/new.csv')

# default encoding: 'Shift_JIS'
CSVSjis.open(file_path, 'w') do |csv|
  csv << %w(言語 都市 記号)
  csv << %w(日本語 東京 －～)
  csv.close
end

file_path.read # => "言語,都市,記号\n日本語,東京,-~\n"

# you can change encoding: 'UTF-8'
CSVSjis.open(file_path, 'w', encoding: 'UTF-8') do |csv|
  csv << %w(言語 都市 記号)
  csv << %w(日本語 東京 －～)
  csv.close
end

file_path.read # => "言語,都市,記号\n日本語,東京,－～\n"
```

## Contributing

1. Fork it ( https://github.com/halenohi/csv_sjis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
