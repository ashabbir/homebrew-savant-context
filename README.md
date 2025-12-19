# Homebrew Tap for Savant Context

Install [Savant Context](https://github.com/ashabbir/context) using Homebrew.

## Installation

### With GitHub Token (Recommended)

```bash
export HOMEBREW_GITHUB_API_TOKEN=your_github_token
brew tap ashabbir/savant-context
brew install savant-context
```

### Manual URL Specification

```bash
export HOMEBREW_GITHUB_API_TOKEN=your_github_token
brew tap ashabbir/savant-context https://github.com/ashabbir/homebrew-savant-context
brew install savant-context
```

## Requirements

- macOS or Linux
- Python 3.10+
- PostgreSQL 15+

## Quick Start

After installation:

```bash
# Initialize the database
savant-context db setup

# Index a repository
savant-context index repo ./path/to/repo

# Check status
savant-context status

# Start the MCP server
savant-context run
```

## Features

- **Full-Text Search** - Search across indexed repositories
- **Code Indexing** - Automatically detect language and index efficiently
- **MCP Compatible** - Works with Claude Desktop and any MCP client
- **Database Management** - Dump and restore indexed data
- **CLI Interface** - Simple commands for all operations
- **No Configuration** - Environment variables only

## Authentication

The Savant Context repository is private. To install with Homebrew, you'll need to authenticate with GitHub:

### Option A: Environment Variable (One-time)

```bash
export HOMEBREW_GITHUB_API_TOKEN=your_github_token
brew tap ashabbir/savant-context
brew install savant-context
```

### Option B: Git Configuration (Permanent)

```bash
git config --global url."https://<token>@github.com/".insteadOf "https://github.com/"
brew tap ashabbir/savant-context
brew install savant-context
```

### Option C: .netrc File (Permanent)

Create `~/.netrc`:
```
machine github.com
login your_username
password your_github_token
```

Then:
```bash
chmod 600 ~/.netrc
brew tap ashabbir/savant-context
brew install savant-context
```

## Documentation

See the [main repository](https://github.com/ashabbir/context) for full documentation.

## License

MIT
