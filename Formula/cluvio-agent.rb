class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "0.1.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/untagged-032341bd052947bffbb9/cluvio-agent-0.1.0-x86_64-apple-darwin.tar.xz"
    sha256 "9c8267a8f46d925ce73049065bb2539adfd36456c8f562b0a7c3fba601cecb95"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/untagged-032341bd052947bffbb9/cluvio-agent-0.1.0-aarch64-apple-darwin.tar.xz"
    sha256 "5d5ab038b6f8fcacd0a63a43985488645f04f6007977a3e3577c0b0c3df7cf53"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/untagged-032341bd052947bffbb9/cluvio-agent-0.1.0-x86_64-unknown-linux-musl.tar.xz"
    sha256 "46915382f1559480d4b2c12cb63aae85a39486b2b3259251fb9c935f02ece0a4"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/untagged-032341bd052947bffbb9/cluvio-agent-0.1.0-aarch64-unknown-linux-musl.tar.xz"
    sha256 "a36f5bbeb0e92a904045fda311cbbc6a5fc2ec634e999c3f72cc3bd5a7a4057b"
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
