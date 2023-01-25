require "../spec_helper"

describe CardanoKit::VERSION do
  describe "shard.yml" do
    it "matches the current version" do
      info = YAML.parse(File.read("./shard.yml"))

      CardanoKit::VERSION.should eq(info["version"])
    end
  end
end
