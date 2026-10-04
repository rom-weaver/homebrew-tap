class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.19.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-cli-assets.tar.gz"
    sha256 "035d0270e67939ffa45edd4f947b29494f6013586eb681cd7d245a5c577c6b22"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "991de3215085949a136818dbd6820d18ef6c067dfe69d28038c30128499ab8e1"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "3bfc5f0dfd20465f53932b69d42991a880b52038d79d1a432872475ba8af22b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "497becfaea171e79a6047dda4117cfca924d888ff573394f0d85af0aa6d0714a"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "3a5d34ef5e1fa43eff79f5101f590e6a465f5d68b496d63b658e32b3c5278b52"
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
