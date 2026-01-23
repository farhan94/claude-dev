FROM node:20-bookworm-slim

# Install minimal useful tooling:
# - git: clone/commit
# - openssh-client: if you use git@... remotes
# - ca-certificates: HTTPS cert validation
# - curl: occasional debugging / fetching scripts
# - less: pager for git/logs
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    ca-certificates \
    curl \
    less \
    tmux \
    gh \
    vim \
  && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create a workspace
WORKDIR /workspace

# Bun (via npm, per Bun v1.3.6 docs)
RUN npm install -g bun

# ralph-tui (via bun)
RUN bun install -g ralph-tui

USER root

# Nice defaults when you "docker run -it ..."
CMD ["bash"]
