class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.3/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "f27a3439e542c096a8997200afe6675638a8c4c09cf4a2b3fe6a14e7c140e4f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.3/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "e2970fddf5ba9611aabbbcf8e5601a42d5578137de8b85139ee795e820057bea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.3/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dc6d15d64430002a11eebbbe8a591adef765f380be91f45f774607a4572fb6c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.3/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "850256f16f4c31734adfe8623fc532960862bbae49ee803b0337c041f10daf97"
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
