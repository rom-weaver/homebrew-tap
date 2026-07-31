class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.10.2"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.2/rom-weaver-darwin-arm64"
      sha256 "79c2342901e5b840fb6fae8da310cf06ebf3700347edf2bf774289641b2a758e"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.2/rom-weaver-darwin-x64"
      sha256 "798546d6d85c321fccfaf0ebe8317bb20b92d747a1ec7821f7751925b310cbf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.2/rom-weaver-linux-arm64-musl"
      sha256 "050f54d098cf364bd8b671e114c0b2045af69beee3f98e65262eff1063e7a416"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.2/rom-weaver-linux-x64-gnu"
      sha256 "39ded9d0dbc1c0135210110bf2284a9ca426591af56abb483f3ec7ff0eb07c4d"
    end
  end

  def install
    bin.install Dir["rom-weaver-*"].first => "rom-weaver"
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
