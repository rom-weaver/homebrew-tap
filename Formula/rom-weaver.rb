class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.22.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-cli-assets.tar.gz"
    sha256 "c8cf59318f6667e5eb1b03e2090ad412310043fa2ee4224483bc287fc4ccd07f"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "d85a456b3ad8fb0370b952a2b5af565f7428ecb09d8e8974a5638314f5c42f74"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "aafc36eda8d7fe8bcf14f654541a61d58b6510178ba53cb8be6c96e89afb08c0"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "96c087e753434d7f3c9ac39425d90d832423e1f8780e34ef0bfd5462cb217424"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "e9a6ea9b8a27bfa0b2161fc3c6490ff09f62108fb80592048da931183265694e"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "ca3f94c33fa1929f7b8ca06755b1b83f142b328b7ab50581ee884c622f4a8000"
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
