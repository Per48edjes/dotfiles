#!/usr/bin/env bash

## INSTALLATION
# bash -c "$(curl -#fL raw.githubusercontent.com/Per48edjes/dotfiles/master/install.sh)"

LOG="${HOME}/Library/Logs/dotfiles.log"
GITHUB_USER="Per48edjes"
GITHUB_REPO="dotfiles"
DIR="${HOME}/code/${GITHUB_REPO}"

_process() {
	echo "$(date) PROCESSING: $*" >>"$LOG"
	printf "$(tput setaf 6) %s...$(tput sgr0)\n" "$@"
}

_success() {
	local message=$1
	printf "%s✓ Success:%s\n" "$(tput setaf 2)" "$(tput sgr0) $message"
}

download_dotfiles() {
	mkdir -p "${DIR}"

	_process "→ Downloading repository to /tmp directory"
	curl -#fLo /tmp/${GITHUB_REPO}.tar.gz "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/master"

	_process "→ Extracting files to ${DIR}"
	tar -zxf /tmp/${GITHUB_REPO}.tar.gz --strip-components 1 -C "${DIR}"

	_process "→ Removing tarball from /tmp directory"
	rm -rf /tmp/${GITHUB_REPO}.tar.gz

	[[ $? ]] && _success "${DIR} created, repository downloaded and extracted"

	# Change to the dotfiles directory
	cd "${DIR}" || exit
}

link_dotfiles() {
	# Symlink files to the HOME directory.
	if [[ -f "${DIR}/opt/dotfiles" ]]; then
		_process "→ Symlinking dotfiles in /configs"

		# Set variable for list of files
		files="${DIR}/opt/dotfiles"

		# Loop through each line in the file
		while IFS= read -r line; do
			# Split the line into source and destination
			IFS=' ' read -r src dst <<<"$line"
			_process "→ Linking ${dst}"
			# Create symbolic link
			ln -fs "${DIR}/${src}" "${HOME}/${dst}"
		done <"$files"

		[[ $? ]] && _success "All files have been copied"
	fi
}

install_homebrew() {
	_process "→ Installing Homebrew"
	xcode-select --install
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	_process "→ Running brew doctor"
	brew doctor

	[[ $? ]] && _success "Installed Homebrew"
}

install_formulae() {
	if ! type -P 'brew' &>/dev/null; then
		echo "Homebrew not found"
		exit 1
	else
		_process "→ Installing Homebrew packages"

		# Update and upgrade all packages
		_process "→ Updating and upgrading Homebrew packages"
		brew update
		brew upgrade
		brew bundle install --file "${DIR}/configs/Brewfile"
		brew cleanup
	fi

	[[ $? ]] && _success "All Homebrew packages installed and updated"
}

install_custom() {
	_process "→ Finishing install with custom code"

	# GHCup
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

	# Install custom plugins (and themes) for Oh My Zsh
	git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/fzf-tab
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	git clone https://github.com/agkozak/zsh-z "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-z
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
	git clone https://github.com/tmux-plugins/tpm "${HOME}"/.tmux/plugins/tpm && chmod 755 "${HOME}"/.tmux

	# Set a custom wallpaper image
	osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"${DIR}/desktop/default_background.jpg"'"'

	[[ $? ]] && _success "All custom code installed"
}

manual_preadjustments() {
	# Oh-My-Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# Set terminal italics and true color
	tic -x "${DIR}/configs/xterm-256color-italic.terminfo"

	[[ $? ]] && _success "Manual adjustments made successfully"
}

update_macos_settings() {
	# Make .macos executable
	_process "→ Setting file permissions"
	chmod u+x "${DIR}/bin/.macos"

	# Execute .macos executable
	_process "→ Updating macOS settings"
	"${DIR}"/bin/.macos

	[[ $? ]] && _success "All configured macOS settings have been updated"
}

install() {
	download_dotfiles
	manual_preadjustments
	install_homebrew
	install_formulae
	link_dotfiles
	install_custom
	# TODO: Fix macOS settings setup script
	update_macos_settings
}

install
