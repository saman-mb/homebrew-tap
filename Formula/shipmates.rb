class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.16.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.16.3/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "944f4c7e742a1b0800cee4288447a56e259f6d3793ad0709bb41dacaf2c64c3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.16.3/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "9709923c98b30dba7c8619194ca133f4234d7d10890caba805ba9aa1235c781a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.16.3/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35411d308b9f6b07aa3bf0e78973e811bb28adfe10479a177b9e40ef5e54c4f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.16.3/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2d79eacd67712af9e49b26e6905a85fdd1b7f8975addc124c7292c4ed0125ee"
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
