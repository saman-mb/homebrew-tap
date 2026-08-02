class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.2/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "5e345cd6b64af5dab6d1db2632619fbcd93264dd591bcadb06be13f3c3e1525c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.2/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "00f4be9cc71edda1336dd7b990e150ae9fc8a53a777a13e27747692b8786f92f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.2/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fc9e9cb2e5aaa57d9387e2309d156ff2ac00aebc6577f115750c608b6238959"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.2/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "55c2c879925f87188af47151a9e9d7530cdaf97964c7c5b6280929654f2a636b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "shipmates" if OS.mac? && Hardware::CPU.arm?
    bin.install "shipmates" if OS.mac? && Hardware::CPU.intel?
    bin.install "shipmates" if OS.linux? && Hardware::CPU.arm?
    bin.install "shipmates" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
