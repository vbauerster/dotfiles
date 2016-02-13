## Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/vbauerster/dotfiles
```

Install rcm

```
$ brew tap thoughtbot/formulae
$ brew install rcm
```

Run rcm (this command expects that you cloned your dotfiles to `~/dotfiles/`)
```
$ env RCRC=$HOME/dotfiles/rcrc rcup
```
RCM creates dotfile symlinks (`.vimrc` -> `/dotfiles/vimrc`) from your home directory to your `/dotfiles/` directory.

### Installing Plugins
Plugins are listed in `vimrc.plug`.

To install them you'll need vim-plug. Installation directions are here: https://github.com/junegunn/vim-plug.
Once vim-plug is installed. Open vim (`$ vim`) and type `:PlugInstall`. And then restart vim. You'll need to do this for all the plugins to work.

### Git Config
Make sure you update ```gitconfig``` with your own name and email address. Otherwise you'll be committing as me. :smile_cat:

#### Custom Fonts
You'll need to use a custom font for Airline to look nice. See here: https://github.com/Lokaltog/powerline-fonts

### Recommended

**cask**
```
$ brew install caskroom/cask/brew-cask
```

**iterm2**
```
$ brew cask install iterm2
```

**solarized**
https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized

**MacVim**
By default OSX has an older version of Vim installed. I recommend installing MacVim and running it from within iterm2. This can be done with brew.
```
$ brew install macvim --override-system-vim
```
This overwrites your default Vim installation. You should restart terminal after installing.

**NeoVim**
```
$ brew tap neovim/homebrew-neovim
$ brew install --HEAD neovim
$ brew reinstall --HEAD neovim
$ sudo pip install --upgrade pip
$ pip install --user neovim
$ pip install --user --upgrade neovim
```

**OS X GUI for NeoVim**
```
$ brew tap rogual/neovim-dot-app
$ brew install --HEAD neovim-dot-app
```

**Prezto**
I use Prezto instead of Bash. Info & installation instructions here: https://github.com/sorin-ionescu/prezto

**Tmux**
```
$ brew install tmux
$ brew install reattach-to-user-namespace
```
