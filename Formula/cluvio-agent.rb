class CluvioAgent < Formula
  desc "Cluvio Agent is a tool that enables Cluvio to connect to databases or services running on your local machine or servers without having to expose them to the internet."
  homepage "https://github.com/cluvio/agent"
  version "1.0.5"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.5/cluvio-agent-1.0.5-x86_64-macos.tar.xz"
    sha256 "de5bdea756f06a84fa07ae9f27098c6aefa112afda7a85a1b5b914c881480122"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cluvio/agent/releases/download/v1.0.5/cluvio-agent-1.0.5-aarch64-macos.tar.xz"
    sha256 "0e94635fb7f005ff8bf1013fa0f7556e1e73005099e836f47ce8c3f04bdea21d"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cluvio/agent/releases/download/v1.0.5/cluvio-agent-1.0.5-x86_64-linux.tar.xz"
    sha256 "8b39561619b8273e3550faa61cd30dd43cc3b4a8974530633c8efe5e21b0fa28"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/cluvio/agent/releases/download/v1.0.5/cluvio-agent-1.0.5-aarch64-linux.tar.xz"
    sha256 "417012be607d3ccaa11644ca39ca28d8370aae8c56902eb5e00f6bcf819140de"
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
