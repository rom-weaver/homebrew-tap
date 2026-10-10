class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.21.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-cli-assets.tar.gz"
    sha256 "12ab61e25f644010fc130106dba766cca66a813ce783fc1c4bb4b41a5416d9f9"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "069b0ed0f7a22b1c42445cf2ea56fc7c4114d50d254819179e97ac40725082d6"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "f9942180f3894fcf9bc5a273e3ab74524bf95ace39cd06dfc71a99bf5a68bdad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "4efc81fa75458aa742f3176c3779ede727fc373ba04fc53e8d3ed25010ea9696"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.21.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "1df41a6efc1c196b287cac51c97032ce1acc17c10af898fde88b62c0771f1c6d"
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
