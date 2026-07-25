class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.8.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.8.0/rom-weaver-darwin-arm64"
      sha256 "cac8c94a87a5bb621b2dc5e0771865b2c43d4dc8ee198bbc8c43196220d41dc2"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.8.0/rom-weaver-darwin-x64"
      sha256 "8f91c79bd541744660ef5e056f122a3845a46889b2c53e3ab163892f0faf6fb9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.8.0/rom-weaver-linux-arm64-musl"
      sha256 "9642ba17ecb88602ed92701ea06efd97a09427678083f9c9c8dbb1d5e5cec953"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.8.0/rom-weaver-linux-x64-gnu"
      sha256 "92987e6152fee2d6c632b694148eb67dbcefd55feb02fe83b534afca50155668"
    end
  end

  def install
    bin.install Dir["rom-weaver-*"].first => "rom-weaver"
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
