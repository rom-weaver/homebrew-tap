class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.20.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-cli-assets.tar.gz"
    sha256 "39656b69d914462f39a76efae580a2341019f8e1a456eb88c0f21a4d7be3ecb6"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "2c5cea918362033d5ed2bd77a3a9fa56a972b50f9816d9ee882ffc3a6f09dc33"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "683488aeb2279381bf92332924d00cc450bc6ee33a469389f3706b8ba21d6719"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "ca3786699db021802983aae621f5c91a867d8f55cdaed098890536bfd98add55"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.20.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "f2fbc3c85732f80c9f11cdf40fc2842260c5d9722287a5287d0c984e7db1494d"
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
