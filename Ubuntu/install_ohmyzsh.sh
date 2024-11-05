#!/bin/bash
#

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/hlissner/zsh-autopair.git ~/.oh-my-zsh/custom/plugins/zsh-autopair
git clone https://github.com/zap-zsh/supercharge.git ~/.oh-my-zsh/custom/plugins/supercharge
git clone https://github.com/wting/autojump.git ~/.oh-my-zsh/custom/plugins/autojump

cd $HOME/.oh-my-zsh/custom/plugins/autojump
./install.py