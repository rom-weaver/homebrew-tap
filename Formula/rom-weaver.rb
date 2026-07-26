class RomWeaver < Formula
  desc "Local-first toolkit for ROMs and disc images: inspect, extract, compress, and apply, create, or bundle patches. Offline via a browser service-worker PWA or CLI."
  homepage "https://rom-weaver.com"
  version "0.9.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.9.0/rom-weaver-darwin-arm64"
      sha256 "7fac93e75ec8632a25fd5a4806292253abb05879f369169aad4c00e00b5e04ea"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.9.0/rom-weaver-darwin-x64"
      sha256 "fa1c4b4c0ce9ec9c3427c363f7917f0bee1939457799a915094a02e32f304670"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.9.0/rom-weaver-linux-arm64-musl"
      sha256 "48580a913b49ea7cc02569710ee3aab83e4b9f1460eecc8e0f5c8de26bfd86c7"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.9.0/rom-weaver-linux-x64-gnu"
      sha256 "c14b7530753555b62bf2a3a1dcdd91169de556be7e1c0acf18824552e9be6be6"
    end
  end

  def install
    bin.install Dir["rom-weaver-*"].first => "rom-weaver"
  end

  test do
    system bin/"rom-weaver", "--version"
  end
end
