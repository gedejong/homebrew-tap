class MtrNg < Formula
  desc "A modern, feature-rich implementation of My Traceroute (MTR) with real-time network path visualization"
  homepage "https://github.com/gedejong/mtr-ng"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.5.0/mtr-ng-aarch64-apple-darwin.tar.xz"
      sha256 "e07dfdc845004423e8bb3aea5b60e51f0824200a4f8c19c6c18dc4c46bc5f28e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.5.0/mtr-ng-x86_64-apple-darwin.tar.xz"
      sha256 "247699a563aade106d469c5802f9ca231acac92566f759216cfdd6919d39d8d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.5.0/mtr-ng-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b0fc3ef16886915851f95a07d91c5e8dddc3d7dc5cf0b9aa4584f4883464bcb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.5.0/mtr-ng-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1417ce6ba282ec699b96c2faaf0df734f96e458cd7b2b5881097c31b4a003dd8"
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
