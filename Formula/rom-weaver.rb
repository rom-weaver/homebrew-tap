class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.15.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-cli-assets.tar.gz"
    sha256 "d4142b04e42e5614f0eba08d3b1385b14f8a46faa6700d74770af75a7f3bd157"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "efa946c60e7b9891d7c74b094a7d4a012fe92852975c39ec2d1a9eadb2822b94"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "872cc1d6c0b2abbf6fbf5a06840d1d52f15046c982d3e445b6f9f8f0f97fc423"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "2156ca044f03c3df1e80d9780d3e1ffb5a77135ff69c6a7f718e7cc800864f88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "dc0cde8cc90776a083113d7cee669d790d79f31a23699a7ab6454d75d776578d"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.15.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "ca7da329c6979b0d9917b147c46c21432d98301080017064d2fea9dbeb32391f"
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
