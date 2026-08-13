# The bluefin-vm tool: a prebuilt arm64 binary from the bluefin-vm project's
# GitHub Release. It ships the TOOL only -- the installed binary downloads the
# VM seed at runtime, so the seed's hosting stays independent of this formula.
# The bluefin-vm repo's release workflow prints the `url` + `sha256` to bump
# below.
class BluefinVm < Formula
  desc "Download, import, and run a Bluefin VM on Apple Silicon"
  homepage "https://github.com/bluefing/bluefin-vm"
  url "https://github.com/bluefing/bluefin-vm/releases/download/v0.3.0/bluefin-vm-0.3.0-aarch64-apple-darwin.tar.gz"
  # No `version` line -- Homebrew scans it from the url.
  sha256 "8f0bdfe38048b04ca1e6289a27553aa176a742a515645f2962611684dfc2c240"
  license "Apache-2.0"

  # Apple Silicon only: the tool drives Apple's Virtualisation framework, and
  # the release ships an arm64 binary.
  depends_on arch: :arm64
  # Imports and runs the VM by shelling out to tart, so brew must pull it in.
  depends_on "openai/tools/tart"

  def install
    bin.install "bluefin-vm"
  end

  test do
    assert_match "bluefin-vm #{version}", shell_output("#{bin}/bluefin-vm --version")
  end
end
