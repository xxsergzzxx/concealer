require 'spec_helper'

describe Concealer::Proxy do

  let(:model) { ConcealedModel.new }
  let(:strategy) { Concealer::Strategy::Allow.new }
  subject { Concealer::Proxy.new(model, strategy) }

  describe "#initializer" do
    it "should require a target and a strategy" do
      expect { Concealer::Proxy.new }.to raise_error ArgumentError
    end

    it "should accept a target object and a strategy" do
      expect { Concealer::Proxy.new(model, Concealer.strategy) }.to_not raise_error ArgumentError
    end
  end

  it "should delegate all unknown method calls to the target" do
    model.should_receive(:allowed_method)
    subject.allowed_method
  end

  it "should ask the strategy whether the method is allowed for the object" do
    strategy.should_receive(:allow?).with(model, :allowed_method, [:args])
    subject.allowed_method(:args)
  end

  it "should return the fallback for unallowed methods" do
    strategy.stub!(:allow?).and_return(false)

    fallback = mock(Concealer::Fallback, :call => :fallback)
    Concealer.stub!(:fallback_for).and_return(fallback)

    subject.allowed_method.should eq(:fallback)
  end
end
