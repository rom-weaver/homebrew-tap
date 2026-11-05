class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.24.0"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-cli-assets.tar.gz"
    sha256 "e1a540f3bb130f232975a1555e2acc5785f5cb1247b2d524055ed5a1fe22b5e9"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "a710a14fcca32aef36015cf7fc8cca9795d7a16f2efa335d4d148f05ac783cbf"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "73e28b3876c45df35d37a9e484c334a0eee23b3956ed96362b9102abe268e5ac"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "0f8db35c1284b6e624878c1521c27f33ff97a949fe35a5dd64757d1766ba6673"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "9cfcbf306105b98edece280e8892ba379d5db53b597fcd7c8f6a75b59f2fa56c"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.24.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "e6e64be86278a2355ffb89d84e5ef8668d4d1f2a2f32a7fc5708aafa9821b6d2"
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
