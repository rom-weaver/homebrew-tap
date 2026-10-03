class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.18.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-cli-assets.tar.gz"
    sha256 "130aec7a612d195dd3fe51dc069b89244bab9849e65ea4de5697c475f4d360aa"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "6187a8c7bc2996b9c836dc037eb15193c9fd91bd13a4484979733abb29f3cb2d"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "d4f9466d9191ec5d6bba548e01e5117c49310ff2d3d38189220d7510436a89d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "106a5b06f2f3fe552d6f6ead28d9664717cb57ed34944a51451f77c0c7cff3a6"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.18.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "4a657d42ff866f2c48af324731d3f15c35a5fcb4715b32cd47220f0f49a0177d"
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
