class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.10.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.0/rom-weaver-darwin-arm64"
      sha256 "592f91f4cfda8b1901af9cdf3d98887168bf9f9210fcc3696bae78ef5f641c94"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.0/rom-weaver-darwin-x64"
      sha256 "42a90b0ad2e5eb118242580cf5b404bd2c1a1962a87990a9062aebd1f6ba9e7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.0/rom-weaver-linux-arm64-musl"
      sha256 "a750f9cc6d4c619723578d87813cc3f73bfc80805e28a0c44ad78343e9199f6c"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.0/rom-weaver-linux-x64-gnu"
      sha256 "9b0babeee93ca86448a376dd8cb960a11e895dac7b04ac48849c7d473d215f57"
    end
  end

  def install
    bin.install Dir["rom-weaver-*"].first => "rom-weaver"
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
