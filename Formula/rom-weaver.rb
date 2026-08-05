class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.12.0"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.0/rom-weaver-cli-assets.tar.gz"
    sha256 "35ff98a8e2627f890b21ca939f0c4ebec1a0e86fa4834c093a668c51b5bd3305"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "5d7ec37c8a21cfd4c6d220bcb576df71dfa917c1db98562f720fbcb4b6b6dc3c"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "4958576001d35be5af2c66575472a9609e0feeca6df72cb8856a512dac0d0ae9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "8cfa2ae6b7d9055c6740743a5b475eaff1ddf3759cab8d3f67d3224d3ea258ed"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "81c9ad15112910796fc318c583c99294677df96cd53013a96f778b2e2aeb7d0a"
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
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
