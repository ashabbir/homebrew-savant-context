class SavantContext < Formula
  include Language::Python::Virtualenv

  desc "Context MCP server with PostgreSQL-based code indexer"
  homepage "https://github.com/ashabbir/context"
  url "https://github.com/ashabbir/homebrew-savant-context/raw/main/savant-context-1.0.0.tar.gz"
  sha256 "e0c41d59a8791dbf89533d39cdfc7e0d4de33aec07c17822d5e50695377f13b3"
  license "MIT"

  depends_on "python@3.10"
  depends_on "postgresql@15"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bbc967cf0d05ecc1e3666d3edfe0952c36a6a9245d556651e215f1e/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c6cac9eda7f268e4038e7a92"
  end

  resource "psycopg" do
    url "https://files.pythonhosted.org/packages/45/4c/4b2e0d559ecef3d693fef154c891edeb6097a17fbb8ae1e0bf1f68f56c38/psycopg-3.1.18.tar.gz"
    sha256 "8ecc938ebc4565f0210a3ac65e5c3bed62cf6758163fa22f4acf9c4bc9f11f1f"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/93/9f/ba0eed0d36a00b2f0f45b4c46a3dab6a3f9ad7b0e11e67c9c5fa33b0e613/pathspec-0.12.1.tar.gz"
    sha256 "a482d51503a1ab33b1c67a6c3813a26953dbdc997c63f13582e6f064f4b4f37a"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/55/59/8bccf4157baf10a8e2866abde872bde1d54544a0b82f3839cba8ab7e5738/pygments-2.17.2.tar.gz"
    sha256 "81a55aa30d7f478417c04d9eed2d4bf205fa3563b23251520326083789b25b8c"
  end

  def install
    # Install Python package and dependencies
    virtualenv_install_with_resources
  end

  def post_install
    # Create data directory if needed
    (var/"savant-context").mkpath
  end

  test do
    system "#{bin}/savant-context", "--version"
    system "#{bin}/savant-context", "--help"
  end

  service do
    run [opt_bin/"savant-context", "run"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/savant-context.log"
    error_log_path var/"log/savant-context.error.log"
  end
end
