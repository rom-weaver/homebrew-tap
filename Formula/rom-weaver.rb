class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.12.2"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.2/rom-weaver-cli-assets.tar.gz"
    sha256 "d726e2d7777504086f9725be15b454bb06f89a9f0afdf385b7052d35cfb955d1"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.2/rom-weaver-darwin-arm64.tar.gz"
      sha256 "c82e55787b374f24fec8bf13f415a6208d5db472808bad6ab3cb2439da2826ac"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.2/rom-weaver-darwin-x64.tar.gz"
      sha256 "f435401815e00cb1c9f4ff79d97475dffb583d8bd640c4646503a42be55c88f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.2/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "79fef9fb1e9131fe87e1b04c9a6544f276c1b141296e3f2bdf9b2590d59b89b5"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.2/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "0c8d249c6f99cd1216d1a09bf9ffb7dba73aae75af54bee5c1360bd7d9b67efe"
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
