# =============================================================================
# Makefile  —  Convenience wrapper around chezmoi commands
# =============================================================================

SHELL := /bin/bash
# Robustly find the chezmoi source directory
SOURCE_DIR := $(shell chezmoi source-path 2>/dev/null)
ifeq ($(SOURCE_DIR),)
  ifeq ($(OS),Windows_NT)
    SOURCE_DIR := $(shell powershell -NoProfile -Command "& chezmoi source-path" 2>nul)
  else
    SOURCE_DIR := $(shell command -v chezmoi >/dev/null && chezmoi source-path 2>/dev/null || echo .)
  endif
endif
.PHONY: install update diff clean edit status help

## install: Apply dotfiles to this machine
install:
	chezmoi apply

## update: Pull latest from GitHub and apply
update:
	chezmoi update

## packages: Manually install required tools (Windows/macOS/Linux)
packages:
ifeq ($(OS),Windows_NT)
	powershell -ExecutionPolicy Bypass -File "$(SOURCE_DIR)\windows\packages.ps1"
else
	@UNAME_S=$$(uname -s); \
	if [ "$$UNAME_S" = "Linux" ]; then \
		bash "$(SOURCE_DIR)/linux/packages.sh"; \
	elif [ "$$UNAME_S" = "Darwin" ]; then \
		brew bundle --file="$(SOURCE_DIR)/macos/Brewfile"; \
	else \
		echo "Unsupported OS: $$UNAME_S"; \
		exit 1; \
	fi
endif

## diff: Preview what would change
diff:
	chezmoi diff

## status: Show managed file status
status:
	chezmoi status

## edit: Edit a managed file (usage: make edit FILE=~/.bashrc)
edit:
ifeq ($(OS),Windows_NT)
	@if not defined FILE (echo Error: FILE argument is required & exit /b 1)
	chezmoi edit $(FILE)
else
	@if [ -z "$(FILE)" ]; then echo "Error: FILE argument is required"; exit 1; fi
	chezmoi edit $(FILE)
endif

## clean: Remove chezmoi source directory (WARNING: destructive)
clean:
ifeq ($(OS),Windows_NT)
	@echo WARNING: This will remove the chezmoi source directory.
	@set /p confirm=Are you sure? [y/N] && if /I not "!confirm!"=="y" exit /b 1
	chezmoi purge
else
	@echo "WARNING: This will remove the chezmoi source directory."
	@read -p "Are you sure? [y/N] " confirm && [ "$$confirm" = "y" ]
	chezmoi purge
endif

## doctor: Check chezmoi setup
doctor:
	chezmoi doctor

## help: Show this help
help:
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/## /  /'
