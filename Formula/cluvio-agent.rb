class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.1.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.1.0/cluvio-agent-1.1.0-x86_64-macos.tar.xz"
    sha256 "3c31c39df810c03d97852a7c45734dfca0a64b8d91bd3dbb0084c7abc33d9d14"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.1.0/cluvio-agent-1.1.0-aarch64-macos.tar.xz"
    sha256 "8c0dc0e07e686c48b250c5b45ba896c0298b0c90fc1c606bc92dcea58d5ab987"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.1.0/cluvio-agent-1.1.0-x86_64-linux.tar.xz"
    sha256 "9e99c74b6dd59dfaa42bed8986e03861e60a195d3ccff1c0705a63c652f9adba"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.1.0/cluvio-agent-1.1.0-aarch64-linux.tar.xz"
    sha256 "ee896939f356737263db316174b8b42b779921cd1337af1fe8b600705436dd0c"
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
