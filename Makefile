all: theme

theme:
	npx @rose-pine/build -f rgb-ansi -t ./src/template.zsh -o ./dist/themes/

install:
	@echo "Installing..."
	@mkdir -p ~/.config/zsh/rose-pine-zsh/themes
	@cp ./dist/themes/*  ~/.config/zsh/rose-pine-zsh/themes
	@cp ./script/*zsh ~/.config/zsh/rose-pine-zsh
	@echo "Installed!"
	@echo " "
	@echo "Activation:"
	@echo " 1. update ~/.zshrc:"
	@echo "       source ~/.config/zsh/rose-pine-zsh/rose-pine-zsh.zsh"
	@echo "       colorize_zsh rose-pine"

.PHONY: test
test:
	@./test/verify-theme.zsh rose-pine
	@./test/verify-theme.zsh rose-pine-moon
	@./test/verify-theme.zsh rose-pine-dawn
	
clean:
	rm -f dist/themes/*.zsh