class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.12.3"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.3/rom-weaver-cli-assets.tar.gz"
    sha256 "e4173eddf782c951e007b4d10789f6d54364e138b4c2c2e788bb85a2cb35cbb8"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.3/rom-weaver-darwin-arm64.tar.gz"
      sha256 "d5cd7efd4cb8ed4043a17c69c1f39e0f2ff531ffb6027f76b999ef108e6807cc"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.3/rom-weaver-darwin-x64.tar.gz"
      sha256 "52cdc9fa55f151b6c89a185514bbe1d885dea12370397e77f2cd17722a107f0f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.3/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "f78b22f9964c50789d04557442d5e340f66ced884c00a16779c1f8b4e1b4109b"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.3/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "3daecd77ae9392cdd23bc46d52dac894d91db5cb97b0a0e986be9d6a49ea5670"
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
