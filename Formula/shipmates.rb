class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.9.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.9.2/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "94351d17a58fc07afb08dfaa8c990a5fc60837c8be907a6bb3ce00ea5e2d139d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.9.2/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "e9417b643cb04f8bcdee67c4c94aaa1868b97b6527e0aee2f6db6479e7ea913d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.9.2/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1bac5ff435898bb19331a981cabacda17465746e32da0546e0f52ec9ded6f316"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.9.2/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6dbb6bb0e130aa0b6e9601e83f51be3e3a00f08d5c714b4d821758771bacbbf8"
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
