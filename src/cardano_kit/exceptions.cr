module CardanoKit
  class Exception < Exception; end

  class NoStakeAddressException < CardanoKit::Exception; end

  class UnknownPrefixExcepiton < CardanoKit::Exception; end
end
