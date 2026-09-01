class Shipmates < Formula
  desc "A crew of specialist AI agents and command workflows that drive a GitHub issue to a reviewed, CI-green pull request"
  homepage "https://saman-mb.github.io/shipmates/"
  version "0.1.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.13/shipmates-aarch64-apple-darwin.tar.xz"
      sha256 "803236172b05120d9a9ca49a88b78d24db3cb825538c715eca7549920b503120"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.13/shipmates-x86_64-apple-darwin.tar.xz"
      sha256 "1e1b95cbab5f811dc7e57772cbb194cfbf1b53bf63cbd13db0ad64155bd390b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.13/shipmates-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "72be673b0ea910c0f1d1892070d7d7767b036717483f62df10ea82de48dbc0fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/saman-mb/shipmates/releases/download/v0.1.13/shipmates-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "db38634e711477aa045644b1633554e2335818fa0db6c1391c726f44c77df8fa"
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
