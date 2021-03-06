## My dotfiles

### Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/vbauerster/dotfiles
```

Install [homebrew](http://brew.sh/) | [cheatsheet](http://ricostacruz.com/cheatsheets/homebrew.html)

Install [rcm](https://thoughtbot.github.io/rcm)
```
$ brew tap thoughtbot/formulae
$ brew install rcm
```

Run rcm (this command expects that you cloned your dotfiles to `~/dotfiles/`)
```
$ env RCRC=$HOME/dotfiles/rcrc rcup
```
RCM creates dotfile symlinks (`.vimrc` -> `/dotfiles/vimrc`) from your home directory to your `/dotfiles/` directory.

### Git Config
Make sure you update ```gitconfig``` with your own name and email address. Otherwise you'll be committing as me. :smile_cat:

### Recommended

**cask**
```
$ brew install caskroom/cask/brew-cask
```

**[iterm2-nightly](http://iterm2.com/nightly/latest)**

**Macvim**

I prefer NeoVim to Vim, but keep MacVim installed just in case.
```
$ brew install macvim --with-override-system-vim --with-python3
```

**Neovim**
```
$ brew tap neovim/homebrew-neovim
$ brew install --HEAD neovim
$ brew reinstall --HEAD neovim
$ sudo pip install --upgrade pip
$ pip install --user neovim
$ pip install --user --upgrade neovim
```

**OS X GUI for NeoVim, there is [more](https://github.com/neovim/neovim/wiki/Related-projects)**
```
$ brew tap rogual/neovim-dot-app
$ brew install --HEAD neovim-dot-app
```

**Universal ctags**
```
$ brew install universal-ctags
```

**jsctags**
```
$ npm install -g git+https://github.com/ramitos/jsctags.git
```

**The silver searcher**
```
$ brew install the_silver_searcher
```

**Prezto**

I use [prezto](https://github.com/sorin-ionescu/prezto), lightweight zsh configuration framework.

***Disclaimer***

If you have noticed that, most mappings are kind a weird in my [vimrc](https://github.com/vbauerster/dotfiles/blob/master/config/nvim/init.vim)
that because I use [Programmer Dvorak](https://github.com/vbauerster/PDvorak) keyboard layout. :banana:
