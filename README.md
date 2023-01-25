# cardano-kit

At toolkit for Crystal to ease developing for the Cardano blockchain.

This shard consists of a series of individual modules that can be combined or
used separately. The main goal is to provide a series of abstractions for
complex implementations, thereby lowering the barriers to entry for development 
on Cardano. It's very much a work in progress, but the contained modules are 
ready for use in production.

![GitHub](https://img.shields.io/github/license/wout/cardano-kit)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wout/cardano-kit)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/wout/cardano-kit/ci.yml?branch=main)

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    cardano_kit:
      github: wout/cardano-kit
  ```

2. Run `shards install`

## Usage

```crystal
require "cardano_kit"
```

### Address

Parse an address from bech32 to its prefix and words:

```crystal
address = CardanoKit::Address.from_bech32("addr1qxdvcswn0exwc2vjfr6u6f6qndf...")
puts address.prefix
# => "addr"
puts address.words
# => Bytes[0, 4, 223, 149, 66, 179, 36, 18, 22, 136, 65, 58, 246, 181, 214, ...]
```

Or parse it from hexbytes using a string or bytes object:

```crystal
CardanoKit::Address.from_bytes("addr", Bytes[0, 4, 223, 149, 66, 179, 36, ...])
# or
CardanoKit::Address.from_hexstring("addr", "0004df9542b324121688413af6b5d6c...")
```

Convert an address to bech32 format:

```crystal
puts address.to_bech32
# => "addr1qxdvcswn0exwc2vjfr6u6f6qndfhmk94xjrt5tztpelyk4yg83zn9d4vrrtzs98lc..."
```

Find the stake address for a given address:

```crystal
puts address.stake_address
# => "stake1uxyrc3fjk6kp343gznlu06w2qddk0f5d5r4znrxzg52zxlclk0hlq"
```

If a short address is provided without the stake address part, this method will
raise a `CardanoKit::NoStakeAddressException`. The `stake_address?` variant of
this method will return `nil` in that case, which may be preferable in some
scenarios.

Finally, an address object can be initialized directly with its prefix and words
arguments:

```crystal
CardanoKit::Address.new("addr", Bytes[0, 4, 223, 149, 66, 179, 36, 18, 22, ...])
```

However, initializing it with an unknown prefix will raise a
`CardanoKit::UnknownPrefixExcepiton`. A safer, but more verbose way to
initialize an address is to use the underlying enums:

```crystal
CardanoKit::Address.new(
  CardanoKit::AddrPrefix::Mainnet,
  Bytes[0, 4, 223, 149, 66, 179, 36, 18, 22, 136, 65, 58, 246, 181, 214, ...]
)
```

Making a typo there will result in a compile-time error, thus avoiding a dreaded
runtime error. Available values are:

```crystal
CardanoKit::AddrPrefix::Testnet # => "addr_test"
CardanoKit::AddrPrefix::Mainnet # => "addr"
CardanoKit::AddrPrefix::StakeTestnet # => "stake_test"
CardanoKit::AddrPrefix::StakeMainnet # => "stake"
```

### CIP08

An implementation of
[CIP08](https://github.com/cardano-foundation/CIPs/tree/master/CIP-0008) for
wallet signature verification on Cardano.

Most common use cases:
1. Proving ownership of a set address.
2. Proving ownership of addresses used in a transaction.
3. Proving ownership of an identity or other off-chain data with a public key attached to it.

```crystal
cip08 = CardanoKit::CIP08.new(key, signature)

# validate the signature
if cip08.signature_valid?
  # get the message
  puts cip08.message
  # => "Hello Crystal!"

  # get the address object
  puts cip08.address.class
  # => CardanoKit::Addresss
else
  puts "Invalid signature!"
end
```

Alternatively, the CIP08 object can be initialized with the signed data object
provided by the client:

```crystal
json_from_client = %({"key":"...","signature":"..."})
signed_data = CardanoKit::CIP08::SignedData.from_json(json_from_client)
cip08 = CardanoKit::CIP08.new(signed_data)
```

**Note**: In its current state, this library won't look in the headers of the
signature, so the COSE key should be provided separately.

## Development

Make sure you have [Guardian.cr](https://github.com/f/guardian) installed. Then
run:

```bash
$ guardian
```

This will automatically:
- run ameba for src and spec files
- run the relevant spec for any file in the src dir
- run spec a file whenever it's saved

## Contributing

1. Fork it (<https://github.com/wout/cardano-kit/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Wout](https://github.com/wout) - creator and maintainer
