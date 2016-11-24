require "spec_helper"

describe Fiedl::Log do
  it "has a version number" do
    expect(Fiedl::Log::VERSION).not_to be nil
  end

  describe "log" do
    let(:log) { Fiedl::Log::Log.new }
    subject { log }

    it { is_expected.to be_kind_of Fiedl::Log::Log }
    it { is_expected.to respond_to :head }
    it { is_expected.to respond_to :section }
    it { is_expected.to respond_to :info }
    it { is_expected.to respond_to :success }
    it { is_expected.to respond_to :warning }
    it { is_expected.to respond_to :error }

  end
end
