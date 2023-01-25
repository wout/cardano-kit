module CardanoKit
  {% begin %}
    {% prefix_map = {
         addr_test:  "Testnet",
         addr:       "Mainnet",
         stake_test: "StakeTestnet",
         stake:      "StakeMainnet",
       } %}

    enum AddrPrefix
      {% for _, value in prefix_map %}
      {{value.id}}
      {% end %}

      def to_s
        case self
        {% for prefix, value in prefix_map %}
        in {{value.id}} then "{{prefix.id}}"
        {% end %}
        end
      end

      def self.from_s(prefix : String)
        case prefix
        {% for prefix, value in prefix_map %}
        when "{{prefix.id}}" then {{value.id}}
        {% end %}
        else
          raise UnknownPrefixExcepiton.new("Unknown prefix '#{prefix}'")
        end
      end
    end

  {% end %}
end
