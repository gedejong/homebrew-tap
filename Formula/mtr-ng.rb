class MtrNg < Formula
  desc "A modern, feature-rich implementation of My Traceroute (MTR) with real-time network path visualization"
  homepage "https://github.com/gedejong/mtr-ng"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.0/mtr-ng-aarch64-apple-darwin.tar.xz"
      sha256 "a8dbbf1854b711d6272678c24712a63ff7784c684d0a26ac2e669a6028874758"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.0/mtr-ng-x86_64-apple-darwin.tar.xz"
      sha256 "84c4c520115b34d3f02dff86ce9ebe4655c4d31f6bc1d56b4b52641251448e3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.0/mtr-ng-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b60864747fb5deb876c079c168cb982b5d053e04b670032b8c4966d2eef0b181"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gedejong/mtr-ng/releases/download/v0.6.0/mtr-ng-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0e14362876e60556f597a59220272d78944c72008b6f4d1f3cae5ade22cb9f7"
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
