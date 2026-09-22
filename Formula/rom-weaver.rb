class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.16.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-cli-assets.tar.gz"
    sha256 "498a1b1fdc6e985b76227852e3593959c136a840c206abc9c3d24a336fd305e6"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "4c920b678761a19ff533a5a95c3f9c750a094ba73e5fce8b888c98bf904ef40a"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "c7b4ab7f8bf127fc8ec9021dbd6dd90e5aacfa5d36a35819df5d775746e9085e"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "c28df6cdc5c252fa77fce02070354e5e7606fb4296abf1371439a423203bc8d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "751a473fe62b17a62db0d510bcb98cc4629707784202c57b93f4378060e6fc98"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.16.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "51db76d87b37559edd42e70b434845b0638d2078959cd85f6eb57188d18da3e9"
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
