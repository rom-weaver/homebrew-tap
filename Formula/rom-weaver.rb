class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.14.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-cli-assets.tar.gz"
    sha256 "0b6f5ce59de8825da1d2b31a63403af695b579ff8a105df9265417f83a743678"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "efa946c60e7b9891d7c74b094a7d4a012fe92852975c39ec2d1a9eadb2822b94"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "aa5afcfb78ee5a91068f6f3e13d79c786f169d7439aa431ab3b7bb5333185105"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "4e9b1331dce471c314adff413ecefcbbd530623c32a29a5de3b2793213cf1f10"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "f4707f46bd5ce4a21f88dab1077950e8502b5b9af19f1b11249de965b57a01e5"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "881fd3b713377b74a41b978b6ae0255e88a67c6476abb75dc531775d04c18c51"
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
