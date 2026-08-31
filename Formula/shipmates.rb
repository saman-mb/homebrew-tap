class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.6/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "ec14bae485faaf359f9a9f8ea03b8986d611d658b586c915499aa4461cbf128f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.6/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "4d8e906972caec6609dbe3e3a0cc715c62dbb516c01210cc9900b5e38c2590a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.6/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10b7243fb8b4955a77c0fbc3969af5da2c5f6d0e295a0f3c9c221067c017e549"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.6/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d5dddad39a7a5eee5e924340e097a51062c731bda9b93a0c1dd45d2b77987978"
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
