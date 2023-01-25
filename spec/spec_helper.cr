require "spec"
require "yaml"
require "../src/cardano_kit"

def testnet_bech32_addr_with_stake
  "addr_test1qqzdl92zkvjpy95ggya0ddwke22c28x68t06s26dmf7e5vglaeslj4r7yyt83ktudh92uxs4qu08x8klfx4psnz8ka7qg85knz"
end

def testnet_addr_byte_string_with_stake
  "0004df9542b324121688413af6b5d6ca95851cda3adfa82b4dda7d9a311fee61f9547e211678d97c6dcaae1a15071e731edf49aa184c47b77c"
end

def testnet_addr_words_with_stake
  Bytes[0, 0, 2, 13, 31, 5, 10, 2, 22, 12, 18, 1, 4, 5, 20, 8, 8, 4, 29, 15, 13, 13, 14, 22, 25, 10, 10, 24, 10, 7, 6, 26, 7, 11, 15, 26, 16, 10, 26, 13, 27, 9, 30, 25, 20, 12, 8, 31, 29, 25, 16, 31, 18, 21, 3, 30, 4, 4, 11, 7, 17, 22, 11, 28, 13, 23, 5, 10, 28, 6, 16, 21, 0, 28, 15, 7, 6, 7, 22, 31, 9, 6, 21, 1, 16, 19, 2, 7, 22, 29, 30, 0]
end

def testnet_addr_bytes_with_stake
  Bytes[0, 4, 223, 149, 66, 179, 36, 18, 22, 136, 65, 58, 246, 181, 214, 202, 149, 133, 28, 218, 58, 223, 168, 43, 77, 218, 125, 154, 49, 31, 238, 97, 249, 84, 126, 33, 22, 120, 217, 124, 109, 202, 174, 26, 21, 7, 30, 115, 30, 223, 73, 170, 24, 76, 71, 183, 124]
end
