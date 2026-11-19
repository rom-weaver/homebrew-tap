class RomWeaver < Formula
  desc "ROM toolkit: apply IPS/BPS/xdelta patches, convert CHD/RVZ/Z3DS, identify ROMs"
  homepage "https://rom-weaver.com"
  version "0.25.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-cli-assets.tar.gz"
    sha256 "db5d977478a4d58dec073e349fabe357225442ef9edc1d1e52db08a04ea9ce3c"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "a710a14fcca32aef36015cf7fc8cca9795d7a16f2efa335d4d148f05ac783cbf"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "1892099c9f9b86a9eeb2ea03f9ace2195b9fb5c75e06b6a9a5e2ebb10a97b4d5"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "a500d91dede3430412ffd162381a5bb5ebb4f54f27baded897ec2e904f1c09cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "043338d227f0d6eaa620ce7ae1511e76042927608164cb2d4dbbeb25e1b72958"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "1353c3578c6a2c55fdbeef18d2366492164bb3fc22ca18b2f59a0e8ff4262b07"
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
