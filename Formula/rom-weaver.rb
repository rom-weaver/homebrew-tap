class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.11.0"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.0/rom-weaver-cli-assets.tar.gz"
    sha256 "91be42dffaf9efd17df5f8f430e75a9fadf30d7e9f2aa6aeebc4621e18784edc"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "c8b2fd98a87c34f559390d0f1d3e68ef1fe6ddbb1ed5784292d3bcdc9f5e88a8"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "888f6b2f9e7fd706bad86efa6512d4d12f4890c92242b3408344430686d0880d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "6e0b1d60e174a6b81e8aa475e695436f0067dbeabc0d621ba615605480992f51"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "4b8c217b4382e9a767223b6aaeb2a5892605b707c659a57f916fda3e906d69f8"
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
