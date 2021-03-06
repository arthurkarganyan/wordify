require 'spec_helper'
require 'yaml'

yaml = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'en_translator_examples.yaml'))
describe EnTranslator do
  subject { EnTranslator.new(num) }
  let(:result) { subject.run }

  yaml.to_a.each do |i|
    context i do
      let(:num) { i.first }
      let(:text) { i.last }
      it { expect(result).to eq(text) }
    end
  end
end
