require 'spec_helper'
require 'fileutils'

describe CSVSjis do
  let(:file_path) do
    RSpec.configuration.spec_root.join('tmp/sample.csv')
  end

  let(:charactors) do
    %w(－ ～)
  end

  let(:source_path) do
    RSpec.configuration.spec_root.join('tmp/source.csv')
  end

  before :each do
    FileUtils.mkdir_p(File.dirname(file_path))
  end

  after :each do
    FileUtils.rm_rf(File.dirname(file_path))
  end

  describe '#open' do
    subject do
      -> {
        CSVSjis.open(file_path, 'w+') do |csv|
          csv << charactors
        end
      }
    end

    it 'not raise error' do
      expect(subject).to_not raise_error
    end

    it 'generate valid csv' do
      subject.call.close
      expect(file_path.read).to eq("-,~\n")
    end
  end
end
