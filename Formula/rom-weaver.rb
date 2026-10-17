class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.22.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-cli-assets.tar.gz"
    sha256 "ce01ad504a1d32d54ff4f13a10e30cd7b4704718a5f27463ad6c2b0f5c1be9b5"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "d85a456b3ad8fb0370b952a2b5af565f7428ecb09d8e8974a5638314f5c42f74"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "93b29b497d8736331bd9a1e8acd35ed4f57701da258cb7b42eae7f99cece4acb"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "788115a4823120af8aaa2c9a682acb181676aff17813abb8b49955daff7b478b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "11f90e71786db5372c9f31fe6cd54109744f7a9ddd62e7fa454369c227a2674c"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "4b78df6f292c494976794aab167eb9f7ec7025c3ce48adadca6d6bc150615860"
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
