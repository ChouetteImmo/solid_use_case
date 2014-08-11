require 'spec_helper'

describe "Control Flow Helpers" do

  describe '#check_exists' do

    class FloodGate
      include SolidUseCase::Composable

      def basic(input)
        check_exists(input).and_then {|x| Success(x * 2) }
      end

      def alias(input)
        maybe_continue(input)
      end

      def custom_error(input, err)
        check_exists(input, err)
      end
    end

    it "stops when the value is nil" do
      result = FloodGate.new.basic(nil)
      expect(result).to fail_with(:not_found)
    end

    it "continues when the value is not nil" do
      result = FloodGate.new.basic(17)
      expect(result).to be_a_success
      expect(result.value).to eq 34
    end

    it "has an alias" do
      result = FloodGate.new.basic(17)
      expect(result).to be_a_success
      expect(result.value).to eq 34
    end

    it "allows a custom error" do
      result = FloodGate.new.custom_error(nil, :my_error)
      expect(result).to fail_with(:my_error)
    end

  end
end