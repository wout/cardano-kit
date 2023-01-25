require "../spec_helper"

describe CardanoKit::Address do
  describe ".initialize" do
    it "can be called with an string prefix" do
      CardanoKit::Address.new("addr_test", testnet_addr_words_with_stake).prefix
        .should eq(CardanoKit::AddrPrefix::Testnet)
    end

    it "raises with an invalid string prefix" do
      expect_raises(CardanoKit::UnknownPrefixExcepiton, "Unknown prefix 'bla'") do
        CardanoKit::Address.new("bla", testnet_addr_words_with_stake)
      end
    end
  end

  describe ".from_bech32" do
    it "parses an address from bech32" do
      address = CardanoKit::Address.from_bech32(testnet_bech32_addr_with_stake)

      address.prefix.should eq(CardanoKit::AddrPrefix::Testnet)
      address.words.should eq(testnet_addr_words_with_stake)
    end
  end

  describe ".from_bytes" do
    it "parses an address from bytes" do
      address = CardanoKit::Address.from_bytes(
        CardanoKit::AddrPrefix::Testnet,
        testnet_addr_bytes_with_stake
      )

      address.words.should eq(testnet_addr_words_with_stake)
    end
  end

  describe "#to_bech32" do
    it "converts an address obect to bech 32" do
      CardanoKit::Address.from_bech32(testnet_bech32_addr_with_stake).to_bech32
        .should eq(testnet_bech32_addr_with_stake)
    end
  end

  describe "#stake_address" do
    it "finds a stake address for mainnet" do
      address = CardanoKit::Address.from_bech32(
        "addr1qxdvcswn0exwc2vjfr6u6f6qndfhmk94xjrt5tztpelyk4yg83zn9d4vrrtzs98lcl5u5q6mv7ngmg829xxvy3g5ydls7c76wu"
      )

      address.stake_address
        .should eq("stake1uxyrc3fjk6kp343gznlu06w2qddk0f5d5r4znrxzg52zxlclk0hlq")
    end

    it "finds a stake address for testnet" do
      address = CardanoKit::Address.from_bech32(
        "addr_test1qqe63xlwltvt0dehyzqdn82eugy79egwzr35pwuu3wrzeqglaeslj4r7yyt83ktudh92uxs4qu08x8klfx4psnz8ka7qcpfveq"
      )

      address.stake_address
        .should eq("stake_test1uq07uc0e23lzz9ncm97xmj4wrg2sw8nnrm05n2scf3rmwlqmds4k5")
    end

    it "can't find a stake address given a base address" do
      address = CardanoKit::Address.from_bech32(
        "addr_test1vqzdl92zkvjpy95ggya0ddwke22c28x68t06s26dmf7e5vg60x4lu"
      )

      expect_raises(CardanoKit::NoStakeAddressException, "No stake address found") do
        address.stake_address
      end
    end
  end

  describe "#stake_address?" do
    it "can't find a stake address given a base address" do
      address = CardanoKit::Address.from_bech32(
        "addr_test1vqzdl92zkvjpy95ggya0ddwke22c28x68t06s26dmf7e5vg60x4lu"
      )

      address.stake_address?.should be_nil
    end
  end
end
