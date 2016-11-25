require 'spec_helper'

describe Translator do
  subject { Translator.new(num) }
  # let(:num) {}

  context "number range" do
    before do
      stub_const("Translator::NUMBER_LIMIT", 10)
    end

    context "ok" do
      before { expect(subject).to receive(:run) }

      context do
        let(:num) { 9 }
        it { subject.try_run }
      end

      context do
        let(:num) { 0 }
        it { subject.try_run }
      end

      context do
        let(:num) { -9 }
        it { subject.try_run }
      end
    end

    context "fail" do
      context do
        let(:num) { 11 }
        it do
          expect {
            subject.try_run
          }.to raise_error(/out of permitted range/)
        end
      end

      context do
        let(:num) do
          -11
        end
        it do
          expect {
            subject.try_run
          }.to raise_error(/out of permitted range/)
        end
      end
    end
  end

  context "only numbers" do
    context do
      let(:num) { "12ho1hr" }
      it do
        expect {
          subject.try_run
        }.to raise_error("Integer numbers only accepted")
      end
    end

    context do
      let(:num) { 8.2 }
      it do
        expect {
          subject.try_run
        }.to raise_error("Integer numbers only accepted")
      end
    end
  end
end
