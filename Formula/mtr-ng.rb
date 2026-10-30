class MtrNg < Formula
  desc "A modern, feature-rich implementation of My Traceroute (MTR) with real-time network path visualization"
  homepage "https://github.com/gedejong/mtr-ng"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.1/mtr-ng-aarch64-apple-darwin.tar.xz"
      sha256 "5ff49eb3c39671a7096e194a43d48882899838be3740d14e3f97c99aaa9c7cd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.1/mtr-ng-x86_64-apple-darwin.tar.xz"
      sha256 "3535e09519f164a90c36bc184aae74033022984e48c88a19ed372459aaef69ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.1/mtr-ng-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5be367c6478218c00b381a6ab42af2d497c7576b586510db9dc22978e726fd11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.1/mtr-ng-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e92671b8004d0b082d056d412a7521402026b904f7deabc6b062f508e7f54aeb"
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
    bash_completion.install "mtr-ng.bash" => "mtr-ng"
    zsh_completion.install "_mtr-ng"
    fish_completion.install "mtr-ng.fish"
    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
