require 'spec_helper'

describe Wordify do
  it "Check input lang" do
    expect {
      Wordify.run(0, :de)
    }.to raise_error(/not implemented/)
  end

  it do
    expect(Wordify.run(0, :en)).to eq('zero')
  end
end
