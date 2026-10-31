class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.18.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.18.0/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "c09510f1f64af56735ab806855c25027596d0de18d5ea636b4a1a1c44c4f2984"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.18.0/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "2928a52e86aae368e14c4354f659dbf125cc3bab0a09b9a9318263a048040e91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.18.0/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12da68bcef6dc96b0e4c6365ba9e5cdbc53d38ec351d9f30a3a9278ad098d995"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.18.0/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e90e8e349091ef28e8fb2556ff037fae7f1306252a7f07b9f2e3c8e466b40bfb"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "shipmates"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shipmates"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shipmates"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shipmates"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
