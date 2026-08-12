class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.13.0"
  license "AGPL-3.0-or-later"

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.13.0/rom-weaver-cli-assets.tar.gz"
    sha256 "5305ef54658c4d87a08771b04f274480523ecfe939b617f8ea6d06d0cb9de6b4"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.13.0/rom-weaver-darwin-arm64.tar.gz"
      sha256 "7f047a950711373be9a5adb3473204b4a121c90e1bcf9acda2c475b5226696c7"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.13.0/rom-weaver-darwin-x64.tar.gz"
      sha256 "dfeef54a0cfcb7bc025c5a051f22f5f91579a7370cbc291cfb8f119afad4dcfe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.13.0/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "8c1abb4767140bb86ac6181332099fa80fa9ebab5b1d6f243c444163f738bce9"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.13.0/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "a100288c79df857bdd6ae69610e5ffff5419599258de20229af5a67ecb2986e3"
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
