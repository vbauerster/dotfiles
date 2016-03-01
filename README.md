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

**Tmux with true color patch**
```
$ brew install https://raw.githubusercontent.com/choppsv1/homebrew-term24/master/tmux.rb
$ brew install reattach-to-user-namespace
```

**Gruvbox color scheme for vim and itemr2**
https://github.com/morhetz/gruvbox

**MacVim**
By default OSX has an older version of Vim installed. I recommend installing MacVim and running it from within iterm2. This can be done with brew.
```
$ brew install macvim --with-override-system-vim --with-python3
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

If you have noticed that, most mappings are kind a weird in my [vimrc](https://raw.githubusercontent.com/vbauerster/dotfiles/master/vimrc)
that because I use [Programmer Dvorak](https://github.com/vbauerster/ProDvorak) keyboard layout. :banana:
