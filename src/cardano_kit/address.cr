struct CardanoKit::Address
  getter prefix : AddrPrefix
  getter words : Bytes

  def initialize(@prefix : AddrPrefix, @words : Bytes)
  end

  def initialize(prefix : String, @words : Bytes)
    @prefix = AddrPrefix.from_s(prefix)
  end

  def to_bech32 : String
    Bech32.encode(prefix.to_s, words, limit: 128)
  end

  def self.from_bech32(address : String)
    prefix, words = Bech32.decode(address, limit: 128)
    new(AddrPrefix.from_s(prefix), words)
  end

  def self.from_bytes(prefix : AddrPrefix | String, bytes : Bytes)
    new(prefix, Bech32.to_words(bytes))
  end

  def self.from_words(prefix : AddrPrefix | String, words : Bytes)
    new(prefix, words)
  end
end
