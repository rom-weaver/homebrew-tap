class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.12.1"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.1/rom-weaver-cli-assets.tar.gz"
    sha256 "b633fbb9c87530e48b6ea8a5119d4d67ea50dfe55fc5a44dff97d49d3c3a0cc2"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.1/rom-weaver-darwin-arm64.tar.gz"
      sha256 "c236867b8b5e0c15a4b04704890f0b23a5c6fc149135a87f4bbbb2bf5eeead56"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.1/rom-weaver-darwin-x64.tar.gz"
      sha256 "e285c8e53b5162b11d88a7d08fe123fa6da03d9e0cd2db408c2fd98f03cb5e46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.1/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "724cacc1548d69661ea46e18df94a5e17a76e59149aef0693a490425669dfd20"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.12.1/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "27331d14e1c34bfe6e1e2be6c50f6972c4e904be283602c824c8653ec82e84a0"
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
