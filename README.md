## My dotfiles

### Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/vbauerster/dotfiles
```

Install [homebrew](http://brew.sh/) | [cheatsheet](http://ricostacruz.com/cheatsheets/homebrew.html)

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

To install them you'll need [vim-plug](https://github.com/junegunn/vim-plug). Open vim (`$ vim`) and type `:PlugInstall`. Restart vim.

### Git Config
Make sure you update ```gitconfig``` with your own name and email address. Otherwise you'll be committing as me. :smile_cat:

#### Custom Fonts
[Powerline fonts](https://github.com/powerline/fonts),
[Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans)

### Recommended

**cask**
```
$ brew install caskroom/cask/brew-cask
```

**[iterm2-nightly](http://iterm2.com/nightly/latest)**

**MacVim**

I prefer NeoVim to Vim, but keep MacVim installed just in case.
```
$ brew install macvim --with-override-system-vim --with-python3
```

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

**Exuberant CTAGS**
```
$ brew install ctags
$ npm install -g git+https://github.com/ramitos/jsctags.git
```

**The silver searcher**
```
$ brew install the_silver_searcher
```

**Prezto**

Lightweight zsh configuration framework. Info & installation instructions here: https://github.com/sorin-ionescu/prezto

***Disclaimer***

If you have noticed that, most mappings are kind a weird in my [vimrc](https://github.com/vbauerster/dotfiles/blob/master/config/nvim/init.vim)
that because I use [Deep Dvorak](https://github.com/vbauerster/DeepDvorak) keyboard layout. :banana:
