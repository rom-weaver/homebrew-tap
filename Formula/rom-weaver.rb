class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.10.1"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.1/rom-weaver-darwin-arm64"
      sha256 "383f874dcf2c29166212d3a64299ce17617a8fdf97abc9f1ea8c091d13ac44bd"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.1/rom-weaver-darwin-x64"
      sha256 "818ec8298049d43cea254988745cff93dff0080074aea6e7f527f5119f652505"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.1/rom-weaver-linux-arm64-musl"
      sha256 "68f3e135ee33826095d86ea79c824c65b0a2da11c0af8b67191e7b2c583a0ba1"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.10.1/rom-weaver-linux-x64-gnu"
      sha256 "dc0fec9f810187b8c3fd6cdf4a706a61f59e9e2456e64b44f0aa118482c403ec"
    end
  end

  def install
    bin.install Dir["rom-weaver-*"].first => "rom-weaver"
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
