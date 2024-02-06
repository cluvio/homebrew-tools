class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.0.6"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.6/cluvio-agent-1.0.6-x86_64-macos.tar.xz"
    sha256 "9dc307121ea792f5844572005d66d266b28254109c27b2681cf02aef8fe0c5bb"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.0.6/cluvio-agent-1.0.6-aarch64-macos.tar.xz"
    sha256 "d739c821651a4e8e5f520763c8ba11fe758ab822517d495b33d492a06ebea06c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.6/cluvio-agent-1.0.6-x86_64-linux.tar.xz"
    sha256 "b07848c2f1e001e5d5746f9aa6fc8ad8bd7812c857fe96affb7495f8c8f670f4"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.0.6/cluvio-agent-1.0.6-aarch64-linux.tar.xz"
    sha256 "f0aa132364c5604f8a500ed07c078ad57ff5c12596d1bb0d4abdf2f401acd13a"
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
