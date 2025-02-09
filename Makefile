.PHONY:  ghostty git mise nvim starship
default: .PHONY

#bootstrap:
#	# ln will fail if repo was already checked out in ~/dotfiles
#	@ln -sfv $(shell pwd -P) ${HOME} || true
#ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
#	@echo "Usage (private/work)?"
#	@read line; echo $$line > ${HOME}/dotfiles/.profile
#endif


ghostty: 
	@chmod +x ghostty/install.sh
	@./ghostty/install.sh

git:
	@chmod +x git/install.sh
	@./git/install.sh

mise: 
	@chmod +x mise/install.sh
	@./mise/install.sh

nvim: mise
	@chmod +x nvim/install.sh
	@./nvim/install.sh

starship: 
	@chmod +x starship/install.sh
	@./starship/install.sh
