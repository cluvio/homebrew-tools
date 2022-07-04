class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.0.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.3/cluvio-agent-1.0.3-x86_64-macos.tar.xz"
    sha256 "7ee025427d0acdcbfba09679be3b2ac658adba1ecb5ab5defa0cc4ca197ca300"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.0.3/cluvio-agent-1.0.3-aarch64-macos.tar.xz"
    sha256 "96d34b637ee8a6201b4f3605f980ccfbf2e7b60a07faaf7feef6e63406e02fd8"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.3/cluvio-agent-1.0.3-x86_64-linux.tar.xz"
    sha256 "fb3fc2d577a7b855bb966bc6253e3ebdb15696acb20e459d0e5eea86f84f1dc4"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.0.3/cluvio-agent-1.0.3-aarch64-linux.tar.xz"
    sha256 "16a6035558e077afcda05c3f71f619944c5fc57cf77caa1dc47e3243196f0a33"
  end

  def install
    bin.install "cluvio-agent"
  end

  plist_options manual: "cluvio-agent"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/cluvio-agent</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <false/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/cluvio-agent/error.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/cluvio-agent/output.log</string>
    </dict>
    </plist>
  EOS
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
