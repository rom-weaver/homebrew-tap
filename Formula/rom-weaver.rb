class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.19.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-cli-assets.tar.gz"
    sha256 "bc90a1b4686ad6de970b3c45d5c15de8a0db2ea5781133d9c98595bbd09ff2c8"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "6d78ae211d1bbb1583731671272b594940f2938ec077bcaffbe395f2a0e5d85b"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "c0365cd1632e94243d31e5b9a533e866095e3e3960b53d2f01b80691b93acd6d"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "97bd231cf220100ab444a8a72f0d6beb8bc3a53fb12dd0e6d31e5a0cf46864ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "89d4adea91c66a4652af31850c551115588c85606872a212ef55805b820d98b2"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.19.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "fb6d21c5320d203fd37e7cb23116b8c8608834034ac0a46bcbeb12eae2d3aaa0"
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
