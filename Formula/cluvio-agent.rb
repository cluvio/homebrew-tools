class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "0.1.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/untagged-7bbb70f20b61c1fc77be/cluvio-agent-0.1.0-x86_64-apple-darwin.tar.xz"
    sha256 "d4876c71a4e5b1d1bc77946a6d2387e05bb8d07e57f33526be779b7e723fdff0"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/untagged-7bbb70f20b61c1fc77be/cluvio-agent-0.1.0-aarch64-apple-darwin.tar.xz"
    sha256 "979ac92c4435b833f4d3407d417cea1e659fb3d92a997505435babb9d4f8ffb2"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/untagged-7bbb70f20b61c1fc77be/cluvio-agent-0.1.0-x86_64-unknown-linux-musl.tar.xz"
    sha256 "936b7c543e82154868fa09114651abd53bc1ef9d1962d0d57fb174e51731a12d"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/untagged-7bbb70f20b61c1fc77be/cluvio-agent-0.1.0-aarch64-unknown-linux-musl.tar.xz"
    sha256 "2782e83176c1e6073adcf8072fc3e3c932918f74a375d8e61c26c91a18bfb8df"
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
