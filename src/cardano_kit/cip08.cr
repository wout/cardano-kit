struct CardanoKit::CIP08
  alias Signature = Tuple(Bytes, NamedTuple(hashed: Bool), Bytes, Bytes)
  alias Headers = Hash(Int32 | String, Bytes | Int32)
  alias Key = Hash(Int32, Bytes | Int32)

  getter headers : Headers
  getter key : Key
  getter signature : Signature

  def initialize(key : String, signature : String)
    @key = Key.from_cbor(key.hexbytes)
    @signature = Signature.from_cbor(signature.hexbytes)
    @headers = Headers.from_cbor(@signature[0])
  end

  def address_bech32(prefix : AddrPrefix)
    Address.from_bytes(prefix, address_bytes).to_bech32
  end

  def address_bech32(prefix : Int32)
    address_bech32(AddrPrefix.from_value(prefix))
  end

  def address_bytes : Bytes
    headers["address"].as(Bytes)
  end

  def message : String
    String.new(signature[2])
  end

  def signature_valid? : Bool
    key_verifier.verify(signature[3], signature_structure)
  end

  private def key_verifier
    Ed25519::VerifyKey.new(key[-2].as(Bytes))
  end

  private def signature_structure
    {"Signature1", signature[0], "".to_slice, signature[2]}.to_cbor
  end
end
