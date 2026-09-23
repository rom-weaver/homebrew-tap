class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.17.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-cli-assets.tar.gz"
    sha256 "2d01c882515f7dc2aecbe6c42c3e7846d3feae01b2b61dc57ad62b17ca4fddee"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "4c920b678761a19ff533a5a95c3f9c750a094ba73e5fce8b888c98bf904ef40a"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "e4ded9e8229ccfe9e08a733fc77b19a79730dcb40acf855078c686b84809c336"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "eb39be6a8371f6143614727be590cad389d2dfb344f0afbd397abbabd225275d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "f23b1f6facda0f325f1ffe5c7226538621ac35f99c710ca29c5d1c1c1cb02067"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.17.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "29cc2634742e41d401ea7bd97b5bb0b45e1e8bda869da4646f79977d5a4ecafa"
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
