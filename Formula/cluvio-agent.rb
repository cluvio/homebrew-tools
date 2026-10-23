class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.4.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.4.0/cluvio-agent-1.4.0-x86_64-macos.tar.xz"
    sha256 "bbbf4a847642515b5519e99eb57cc09ef1db1cc16aef4b32a06023bd60d79315"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.4.0/cluvio-agent-1.4.0-aarch64-macos.tar.xz"
    sha256 "d4c78a7e2091999cdfcc6bc4f7d2589c494eb55bb90c7d12ba7a598e460b2005"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.4.0/cluvio-agent-1.4.0-x86_64-linux.tar.xz"
    sha256 "34ce5dc6193a20a736130343d6fbc0d7403181ddc1f1327ed35a72aa23b4db64"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.4.0/cluvio-agent-1.4.0-aarch64-linux.tar.xz"
    sha256 "8d5f4514bd9469accc1c207717a3b0463c77b7574b3d4e93a05f9324378f5ae0"
  end

  def install
    bin.install "cluvio-agent"
  end

  service do
    run opt_bin/"cluvio-agent"
    working_dir HOMEBREW_PREFIX
    log_path  var/"log/cluvio-agent/output.log"
    error_log_path var/"log/cluvio-agent/error.log"
  end

  def caveats
    if OS.mac?
      <<~EOS
        \u001b[32mFinish the setup:\u001b[0m You need to add the agent to your account on Cluvio here: \u001b[4mhttps://app.cluvio.com/settings/datasources/agents/new\u001b[0m
        When the agent is added, you will be prompted to download the config file. Do so and place it in your home directory.

        You can then start the agent in one of 2 ways:
        1. simply run \u001b[34m`cluvio-agent`\u001b[0m in a terminal, Ctrl-C to stop it
        2. use \u001b[34m`brew services start cluvio-agent`\u001b[0m to run it as a launchctl daemon
      EOS
    end
  end

  if OS.linux?
    <<~EOS
      \u001b[32mFinish the setup:\u001b[0m You need to add the agent to your account on Cluvio here: \u001b[4mhttps://app.cluvio.com/settings/datasources/agents/new\u001b[0m
      When the agent is added, you will be prompted to download the config file. Do so and place it in your home directory.

      You can then start the agent by running \u001b[34m`cluvio-agent`\u001b[0m in a terminal, Ctrl-C to stop it
    EOS
  end

  test do
    system "#{bin}/cluvio-agent --version"
  end
end
