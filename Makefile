.DEFAULT_GOAL := install

XBINDKEYSRC := $(HOME)/.xbindkeysrc
SHORTCUT_KEY := F10
SCRIPT := $(HOME)/timestamp_kb_shortcut.sh

GREEN := \033[0;32m
NC := \033[0m

install: create_script make_script_executable check_xbindkeysrc write_xbindkeysrc restart_xbindkeys post_install_instructions

create_script:
	@echo "#!/bin/bash" > $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Dependencies" >> $(SCRIPT)
	@echo "# xdotool" >> $(SCRIPT)
	@echo "# xbindkeys" >> $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Ubuntu Install:" >> $(SCRIPT)
	@echo "# sudo apt install xdotool xbindkeys" >> $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Get the current Unix timestamp" >> $(SCRIPT)
	@echo "timestamp=\$$(date +%s)" >> $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Write timestamp to a log file for debugging" >> $(SCRIPT)
	@echo 'echo "Timestamp: $$timestamp" >> /tmp/timestamp.log' >> $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Add a delay before typing" >> $(SCRIPT)
	@echo "sleep 0.3" >> $(SCRIPT)
	@echo "" >> $(SCRIPT)
	@echo "# Simulate typing the timestamp at the cursor position" >> $(SCRIPT)
	@echo 'xdotool type "$$timestamp"' >> $(SCRIPT)

make_script_executable:
	@chmod +x $(SCRIPT)
	@echo "$(GREEN)1:$(NC) Making $(SCRIPT) executable."

check_xbindkeysrc:
	@if [ -f $(XBINDKEYSRC) ]; then \
		echo "$(GREEN)2:$(NC) File $(XBINDKEYSRC) already exists. Not touching it."; \
	else \
		touch $(XBINDKEYSRC); \
		echo "$(GREEN)2:$(NC) Created $(XBINDKEYSRC)."; \
	fi

write_xbindkeysrc:
	@if ! grep -q "\"$(SCRIPT)\"" $(XBINDKEYSRC); then \
		echo "\"$(SCRIPT)\"" >> $(XBINDKEYSRC); \
		echo "    $(SHORTCUT_KEY)" >> $(XBINDKEYSRC); \
		echo "$(GREEN)3:$(NC) Appended shortcut for $(SCRIPT) to $(XBINDKEYSRC)."; \
		echo "    Shortcut: $(SHORTCUT_KEY)"; \
	else \
		echo "$(GREEN)3:$(NC) Shortcut for $(SCRIPT) already exists in $(XBINDKEYSRC)."; \
	fi

restart_xbindkeys:
	@echo "$(GREEN)4:$(NC) Restarting xbindkeys server."
	@pkill xbindkeys || true  # Kill existing xbindkeys server if running
	@xbindkeys &

post_install_instructions:
	@if [ -z "$$(which xdotool)" ] || [ -z "$$(which xbindkeys)" ]; then \
		echo "\n$(GREEN)Post Install Instructions:$(NC)"; \
		echo "To execute the script, you need to install the following dependencies:"; \
		echo "    xdotool and xbindkeys"; \
		echo ""; \
		echo "On Ubuntu, you can install them using the following command:"; \
		echo "    $$ sudo apt install xdotool xbindkeys"; \
		echo ""; \
		echo "After installing \`xbindkeys\`, run the server:"; \
		echo "    $$ xbindkeys"; \
	fi

.PHONY: install create_script make_script_executable check_xbindkeysrc write_xbindkeysrc restart_xbindkeys post_install_instructions
