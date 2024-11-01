
# INSTALL PATH
EXE_DIR := /usr/local/bin

# EXECUTABLE
EXE = ssh-agent-manager

.PHONY: all
all:
	install --verbose --mode=755 --owner=root --group=root ${EXE} ${EXE_DIR}

