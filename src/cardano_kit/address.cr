struct CardanoKit::Address
  LIMIT = 128

  getter prefix : AddrPrefix
  getter words : Bytes

  def initialize(@prefix : AddrPrefix, @words : Bytes)
  end

  def initialize(prefix : String, @words : Bytes)
    @prefix = AddrPrefix.from_s(prefix)
  end

  def to_bech32 : String
    Bech32.encode(prefix.to_s, words, limit: LIMIT)
  end

  def stake_address? : String?
    return unless (decoded = Bech32.from_words(words).hexstring).size == 114

    Bech32.encode(
      AddrPrefix.from_value(prefix.value + 2).to_s,
      Bech32.to_words("e#{prefix.value}#{decoded[-56..]}".hexbytes),
      limit: LIMIT
    )
  end

  def stake_address : String
    stake_address? || raise NoStakeAddressException.new("No stake address found")
  end

  def self.from_bech32(address : String)
    prefix, words = Bech32.decode(address, limit: LIMIT)
    new(AddrPrefix.from_s(prefix), words)
  end

  def self.from_bytes(prefix : AddrPrefix | String, bytes : Bytes)
    new(prefix, Bech32.to_words(bytes))
  end
end
