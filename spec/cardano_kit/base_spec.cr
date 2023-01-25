require "../spec_helper"

describe CardanoKit do
  describe CardanoKit::AddrPrefix do
    describe "#to_s" do
      it "handles a mainnet prefix" do
        CardanoKit::AddrPrefix::Mainnet.to_s.should eq("addr")
      end

      it "handles a testnet prefix" do
        CardanoKit::AddrPrefix::Testnet.to_s.should eq("addr_test")
      end

      it "handles a mainnet stake prefix" do
        CardanoKit::AddrPrefix::StakeMainnet.to_s.should eq("stake")
      end

      it "handles a testnet stake prefix" do
        CardanoKit::AddrPrefix::StakeTestnet.to_s.should eq("stake_test")
      end
    end

    describe "#from_s" do
      it "handles a mainnet prefix" do
        CardanoKit::AddrPrefix.from_s("addr")
          .should eq(CardanoKit::AddrPrefix::Mainnet)
      end

      it "handles a testnet prefix" do
        CardanoKit::AddrPrefix.from_s("addr_test")
          .should eq(CardanoKit::AddrPrefix::Testnet)
      end

      it "handles a mainnet stake prefix" do
        CardanoKit::AddrPrefix.from_s("stake")
          .should eq(CardanoKit::AddrPrefix::StakeMainnet)
      end

      it "handles a testnet stake prefix" do
        CardanoKit::AddrPrefix.from_s("stake_test")
          .should eq(CardanoKit::AddrPrefix::StakeTestnet)
      end
    end
  end
end
