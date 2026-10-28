class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.23.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-cli-assets.tar.gz"
    sha256 "073b8e5567a8fce841aa7da2fdca564254c1d9dc57c76d1732558e97cea7fff8"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "a710a14fcca32aef36015cf7fc8cca9795d7a16f2efa335d4d148f05ac783cbf"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "86fea728da3c01a6cf01029af3d3270377a8e3fb049f871286e8bcf05d939163"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "e430825cf03dce2142908a5547930f99e4cd56f872b7bd1b2240e36353138969"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "aba9d5796bc21d721c61754c1a3acb0546e2e6d6915fa57c0d8275e5ca09ad2a"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.23.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "ce748cd58971fd6195f0986179256288de0604c558abe30f89e46a13aacfc1c9"
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
