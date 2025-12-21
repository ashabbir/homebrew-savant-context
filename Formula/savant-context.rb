class SavantContext < Formula
  desc "Context MCP server with PostgreSQL-based code indexer"
  homepage "https://github.com/ashabbir/context"
  url "https://github.com/ashabbir/homebrew-savant-context/raw/main/savant-context-1.0.0.tar.gz"
  sha256 "e0c41d59a8791dbf89533d39cdfc7e0d4de33aec07c17822d5e50695377f13b3"
  license "MIT"

  depends_on "python@3.10"
  depends_on "postgresql@15"

  def check_python_dependencies
    python = "python3.10"
    required_packages = ["click", "psycopg", "pathspec", "pygments"]
    missing = []

    required_packages.each do |pkg|
      result = system("#{python} -c 'import #{pkg.gsub('-', '_')}' 2>/dev/null")
      missing << pkg unless result
    end

    return true if missing.empty?

    puts "\n❌ Missing Python dependencies for savant-context:"
    missing.each { |pkg| puts "  - #{pkg}" }
    puts "\nInstall them with:"
    puts "  python3.10 -m pip install --break-system-packages #{missing.join(' ')}"
    puts "\nThen retry: brew install savant-context\n\n"
    false
  end

  def install
    odie "Python dependencies not installed. See instructions above." unless check_python_dependencies

    # Copy the tarball contents to the installation prefix
    system "cp -r . #{prefix}"

    # Install the Python package
    system "#{Formula["python@3.10"].bin}/python3.10 -m pip install --target #{prefix}/lib/python3.10/site-packages #{prefix}"
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
