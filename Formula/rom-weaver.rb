class RomWeaver < Formula
  desc "Offline ROM toolkit: patch, convert, identify, bake in cheat codes, and edit supported game saves. No telemetry."
  homepage "https://rom-weaver.com"
  version "0.22.2"
  license "AGPL-3.0-or-later"
  depends_on "brotli" => :build

  resource "cli-assets" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-cli-assets.tar.gz"
    sha256 "bb34e9e569141787d1764cbaa4fb147be6f0e6140bc629e8940a2bb10cf49e28"
  end

  resource "identify-data" do
    url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-identify-data.tar.br", using: :nounzip
    sha256 "d85a456b3ad8fb0370b952a2b5af565f7428ecb09d8e8974a5638314f5c42f74"
  end

  on_macos do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-darwin-arm64.tar.gz"
      sha256 "3fbbe0bb01db685254e3e806504f8a5c40299f4aadf2df86586198ddba9859bb"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-darwin-x64.tar.gz"
      sha256 "2eca82101150d2b8c55b228bb76f9a280a87a4123f3806577e708e13e4f22163"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-linux-arm64-musl.tar.gz"
      sha256 "d275f071401f28da812dff1030f79586c6bc6ad1d63f5584fc76f8f13d7f58f2"
    end
    on_intel do
      url "https://github.com/rom-weaver/rom-weaver/releases/download/v0.22.2/rom-weaver-linux-x64-gnu.tar.gz"
      sha256 "27ecb8a144854fa2f565bca979b1884476dde83b98168adf6a340971ba5f2000"
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
