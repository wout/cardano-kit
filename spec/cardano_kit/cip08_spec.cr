require "../spec_helper"

describe CardanoKit::CIP08 do
  describe "#signature_valid?" do
    it "tests positive with a valid key" do
      CardanoKit::CIP08.new(valid_key, valid_signature).signature_valid?
        .should be_truthy
    end

    it "tests negative with an invalid key" do
      CardanoKit::CIP08.new(invalid_key, valid_signature).signature_valid?
        .should be_falsey
    end
  end

  describe "#message" do
    it "returns the original" do
      CardanoKit::CIP08.new(valid_key, valid_signature).message
        .should eq("Hello Crystal!")
    end
  end

  describe "#address_bytes" do
    it "returns the address as bytes" do
      CardanoKit::CIP08.new(valid_key, valid_signature).address_bytes
        .should eq(testnet_addr_bytes_with_stake)
    end
  end

  describe "#address_bech32" do
    it "returns the address in bech32-encoded format" do
      CardanoKit::CIP08.new(valid_key, valid_signature)
        .address_bech32(CardanoKit::AddrPrefix::Testnet)
        .should eq(testnet_bech32_addr_with_stake)
    end
  end
end

def valid_key
  "a4010103272006215820d67eecc835667bb86b0dab8e787652b1ad037691ff0cfc14a2b7f4990d9f156f"
end

def valid_signature
  "845846a20127676164647265737358390004df9542b324121688413af6b5d6ca95851cda3adfa82b4dda7d9a311fee61f9547e211678d97c6dcaae1a15071e731edf49aa184c47b77ca166686173686564f44e48656c6c6f204372797374616c215840eccf68d3c20b4b2d515e98e22af8681da6d165683ccf1249dd4c43833b2861036f4894afa87db6178e4bd974b950550c9c0bfb06f854ee59787bec067da87e00"
end

def invalid_key
  "a4010103272006215820602bff2fc5cd4752e2f0dac3bedb83295f25bab06ea3376ad9b576de2233a29f"
end

def sisig
  "845846a20127676164647265737358390004df9542b324121688413af6b5d6ca95851cda3adfa82b4dda7d9a311fee61f9547e211678d97c6dcaae1a15071e731edf49aa184c47b77ca166686173686564f458c37b226e6f6e6365223a226979325945676b316566783247433564753343536b62446d7066386c444a5477424631764d77793941646f3d222c2261646472657373223a22616464725f746573743171717a646c39327a6b766a7079393567677961306464776b653232633238783638743036733236646d6637653576676c6165736c6a34723779797438336b747564683932757873347175303878386b6c66783470736e7a386b6137716738356b6e7a222c2277616c6c6574223a22657465726e6c227d58402560b334ee6229f6392d755f238ef11a93013a50f0b285e935905dd2d7a4bdfbdfc9240b8700ac5b158f5f75da01281004179e987e1e29610466688fcfa52500"
end
