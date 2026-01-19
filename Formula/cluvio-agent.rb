class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.2.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.3.0/cluvio-agent-1.3.0-x86_64-macos.tar.xz"
    sha256 "b98394ac477b1a395c6c9153a0434764fe7f6be28913e4557540a71c7b072e70"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.3.0/cluvio-agent-1.3.0-aarch64-macos.tar.xz"
    sha256 "89fcd6166ba0bce9fa38abec3f9661060c04cef9f27227c4de40df1eada2c4dd"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.3.0/cluvio-agent-1.3.0-x86_64-linux.tar.xz"
    sha256 "eb5e255a8679a94fab2ca4950c1da0e77ae8bc703d13f8c9f0adbb190ae57076"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.3.0/cluvio-agent-1.3.0-aarch64-linux.tar.xz"
    sha256 "b6745948a2d90c91c68c5c3b0e771023ec529840e4df9fae82fb26e664e06e06"
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
