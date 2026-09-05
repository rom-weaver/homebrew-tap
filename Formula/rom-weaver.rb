class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.14.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-cli-assets.tar.gz"
    sha256 "23ecf2c644e8f198ff070d8eea5c56fb27f7a37985a188c9dc993f3c4a752def"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "efa946c60e7b9891d7c74b094a7d4a012fe92852975c39ec2d1a9eadb2822b94"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "918d8975ce9bbdd01879169e5be233408ede5ed3681c282b697c5fddcfd09cd7"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "239d38fcd485c76fb93ae3389ce4dfb831aea442123b09b194a2228373e52246"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "705d12930c07883d9d34c4d7b8045fed18eb58c687adff09e25008153c2d7595"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.14.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "e288dbb0ae02dbdcde0d0670805b20aa8cb312a6b2f8a533c055052dcc03ff7b"
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
      system "brotli", "--decompress", "--force", "--output", "identify-data.tar", "rom-weaver-identify-data.tar.br"
      system "tar", "--extract", "--file", "identify-data.tar"
      share.install "share/rom-weaver"
    end
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
