class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.20.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-cli-assets.tar.gz"
    sha256 "7fb97eb41d5e49a24357e1e3a40fbbbc78aa2c178be22ae4cbe51ccb23277ad5"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "a717b01c83e235ea8f00f4f6f166d6595e1dd7bb707e8e224f75143bffa11c22"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "f0210efa73a48969d5b0539e6e3f44f17d9559450f4529ae8f0507fe3207e2fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "7217ae4e7ef2790b0fc76423bcf03418c017240f33478eaf3d7254eed4646d90"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "173ac5bc0f51ca97f6ac8552fed866d698b0ee764221c021a6045f5b25f1e881"
    end
  end

  def install
    bin.install "rom-weaver"
    resource("cli-assets").stage do
      man1.install Dir["man/*.1"]
      bash_completion.install "completions/rom-weaver.bash" => "rom-weaver"
      zsh_completion.install "completions/_rom-weaver"
      fish_completion.install "completions/rom-weaver.fish"
    end
    resource("identify-data").stage do
      system "brotli", "--decompress", "--force", "--output=identify-data.tar", "rom-weaver-identify-data.tar.br"
      system "tar", "--extract", "--file", "identify-data.tar"
      share.install "share/rom-weaver"
    end
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
