class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.11.1"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.1/rom-weaver-cli-assets.tar.gz"
    sha256 "6842fb3080baa38303635d7f967d7a138a52a99ca35a76e30caa8e449d41170a"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "cc8fca58e938135dcbac46f3ba79bcc5130961cb821012fa11b439c459b3c743"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "1047fe1bf533393fb57508bc18f2a0250419e28f933db95329d93e5b73c02e21"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "ecf91ac4b59bf628722f8b71bf6fcd165f1c0a915c69afab55266ff0d344ab81"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.11.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "2f7752e304438268830cbf29ca9417d6240a76e381a238bc3a183811106e7546"
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
