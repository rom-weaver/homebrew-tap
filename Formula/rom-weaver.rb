class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.16.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-cli-assets.tar.gz"
    sha256 "b946e836cf5d2db04f85fc34bcc41365edf43b1a09c7e7a229dd0f89068f2cfa"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "4c920b678761a19ff533a5a95c3f9c750a094ba73e5fce8b888c98bf904ef40a"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "b82edc85089a6d706e24af2f0a76e51fce34ed69d2ea51974b86c15df9bdcd87"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "41e259fea4a19cb841f85b70b5006185d69e41fb95b5291ccd8a338c75e48812"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "ee299319fd3a87ba08d67fdb82a948871a39b54dd23e3dde033c6a34ec7e88ee"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "a5a0af90e2f8bb3ebbfe4fd9ce092155901fd3b9a50533904386e1bf89a3c282"
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
