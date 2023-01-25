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

  describe ".from_words" do
    it "parses an address from bytes" do
      from_words = CardanoKit::Address.from_words(
        CardanoKit::AddrPrefix::Testnet,
        testnet_addr_words_with_stake
      )
      from_initializer = CardanoKit::Address.new(
        CardanoKit::AddrPrefix::Testnet,
        testnet_addr_words_with_stake
      )

      from_words.should eq(from_initializer)
    end
  end

  describe "#to_bech32" do
    it "converts an address obect to bech 32" do
      CardanoKit::Address.from_bech32(testnet_bech32_addr_with_stake).to_bech32
        .should eq(testnet_bech32_addr_with_stake)
    end
  end
end
