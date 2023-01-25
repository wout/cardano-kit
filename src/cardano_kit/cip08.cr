struct CardanoKit::CIP08
  alias Signature = Tuple(Bytes, NamedTuple(hashed: Bool), Bytes, Bytes)
  alias Headers = Hash(Int32 | String, Bytes | Int32)
  alias Key = Hash(Int32, Bytes | Int32)

  getter key : Key
  getter signature : Signature

  def initialize(key : String, signature : String)
    @key = Key.from_cbor(key.hexbytes)
    @signature = Signature.from_cbor(signature.hexbytes)
  end

  def initialize(data : SignedData)
    @key = Key.from_cbor(data.key.hexbytes)
    @signature = Signature.from_cbor(data.signature.hexbytes)
  end

  def address(prefix : AddrPrefix) : Address
    Address.from_bytes(prefix, address_bytes)
  end

  def address_bytes : Bytes
    headers["address"].as(Bytes)
  end

  def headers : Headers
    Headers.from_cbor(signature[0])
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

  struct SignedData
    include JSON::Serializable

    getter key : String
    getter signature : String
  end
end
