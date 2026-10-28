class MtrNg < Formula
  desc "A modern, feature-rich implementation of My Traceroute (MTR) with real-time network path visualization"
  homepage "https://github.com/gedejong/mtr-ng"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.4.0/mtr-ng-aarch64-apple-darwin.tar.xz"
      sha256 "cecac9b21cb8ea63d01489894e1b3abc103097596898e7f8b62036c0c41799f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.4.0/mtr-ng-x86_64-apple-darwin.tar.xz"
      sha256 "cdd12630dd98d5776d2fdc4fcdcda7aefc7a089fa5e4d336ce356f9ad86d0623"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.4.0/mtr-ng-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a94905c24c7cea4cbef6839081667445d45b68d463d273aef7facc0718c263e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.4.0/mtr-ng-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6f3e37a14f28cb6c5cd7a110d9656cdd17597bac297917a4669d7eb873bffa6"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "mtr-ng"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mtr-ng"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mtr-ng"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mtr-ng"
    end

    man1.install "mtr-ng.1"
    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
