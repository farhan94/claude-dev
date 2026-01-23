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

#unnecessary but might as well:
USER root

ENV TERM=xterm-256color
ENV PS1="\[\e[1;36m\]\u@\h\[\e[0m\]:\[\e[1;35m\]\w\[\e[0m\]\$ "

# Nice defaults when you "docker run -it ..."
CMD ["bash"]
