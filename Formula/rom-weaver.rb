class RomWeaver < Formula
  desc "ROM toolkit: apply IPS/BPS/xdelta patches, convert CHD/RVZ/Z3DS, identify ROMs"
  homepage "https://rom-weaver.com"
  version "0.25.1"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-cli-assets.tar.gz"
    sha256 "2fc3a661779be4c96a8a9e3ac527973f11672b17e05c9f6d3e5bb7d7d7d573c6"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "a710a14fcca32aef36015cf7fc8cca9795d7a16f2efa335d4d148f05ac783cbf"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "70060cee796d337610c1932692973455db21cf4a702274eff275e952378a0067"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "a2e21b3a492cdbd56a5ec378260ff8c876d91944c67cf772665f08a6c84f9397"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "0162147ada66a923095c0112d308498eae0ddd968f4457557984b5a57e6dc2b9"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.25.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "997542c8721395f6cc79d6d17a72fdbdb0da22ace79c024b3431f25fda393cf9"
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
