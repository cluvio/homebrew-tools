class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.2.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.2.0/cluvio-agent-1.2.0-x86_64-macos.tar.xz"
    sha256 "169a2687ecb65c77abc712781d2eb732150565c6c7e91e44eebf353cc6466eca"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.2.0/cluvio-agent-1.2.0-aarch64-macos.tar.xz"
    sha256 "dacaa2d8de46e1cacc72f76f2150918e4ea746dae34dfa1b4e9a64c3499f8cbf"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.2.0/cluvio-agent-1.2.0-x86_64-linux.tar.xz"
    sha256 "a1f6e310f1c4d7f8fe032685253577cd1d801c7a4187e35779e24fb533c72e2d"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.2.0/cluvio-agent-1.2.0-aarch64-linux.tar.xz"
    sha256 "9750986f1638183f438ccaf7da035284f84939527828b7721ad3427ab1a99044"
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
