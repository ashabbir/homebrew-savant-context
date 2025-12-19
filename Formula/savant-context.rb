class SavantContext < Formula
  include Language::Python::Virtualenv

  desc "Context MCP server with PostgreSQL-based code indexer"
  homepage "https://github.com/ashabbir/context"
  url "https://github.com/ashabbir/homebrew-savant-context/raw/main/savant-context-1.0.0.tar.gz"
  sha256 "835cf6477c55e62de71b3e44e5f9288b35b32f8bda9518df488ab6ea4e15b1b3"
  license "MIT"

  depends_on "python@3.10"
  depends_on "postgresql@15"

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
