;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; better-defaults
     helm
     emacs-lisp
     org
     (git :variables
          git-magit-status-fullscreen t)
     (version-control :variables
                      ;; default diff-tool is 'git-gutter+
                      ;; version-control-diff-tool 'diff-hl
                      version-control-diff-side 'left)
     (auto-completion :variables
                      ;; auto-completion-enable-snippets-in-popup t
                      auto-completion-return-key-behavior nil
                      ;; auto-completion-tab-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-help-tooltip 'manual)
     (syntax-checking :variables
                      ;; syntax-checking-use-original-bitmaps t
                      syntax-checking-enable-by-default nil)
     (spell-checking :variables
                     enable-flyspell-auto-completion t
                     spell-checking-enable-by-default nil)
     html
     markdown
     neotree
     yaml
     python
     ;; (java :variables java-backend 'eclim)
     java
     javascript
     (rust :variables rust-format-on-save t)
     (go :variables
         go-tab-width 4
         gofmt-command "goimports"
         go-use-gometalinter t
         godoc-at-point-function 'godoc-gogetdoc)
     protobuf
     docker
     themes-megapack
     dash
     semantic
     (ranger :variables
             ;; ranger-max-preview-size 4
             ranger-show-preview t
             ranger-show-literal t)
     (shell :variables
            shell-default-shell 'eshell
            shell-default-height 30
            shell-default-position 'bottom)
     shell-scripts
     (c-c++ :variables
            c-c++-enable-clang-support t
            c-c++-enable-rtags-support t)
     ;; (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     ;; (keyboard-layout :variables kl-layout 'dvorak)
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(discover-my-major)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(vim :variables
                                    vim-style-visual-feedback t)

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(leuven
                         ;; sanityinc-solarized-light
                         zenburn
                         anti-zenburn
                         ample-light
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.2)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka"
                               :size 12
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t

   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t

   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   ;; dotspacemacs-retain-visual-state-on-shift t

   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   ;; dotspacemacs-visual-line-move-text nil

   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   ;; dotspacemacs-ex-substitute-global nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols nil

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setenv "RIPGREP_CONFIG_PATH" "/Users/vbauer/.rgrc")
  (setq-default
   vc-follow-symlinks t
   evil-shift-round nil
   evil-escape-key-sequence ",."
   select-enable-clipboard nil
   ;; make-backup-files nil
   shell-default-term-shell "/usr/local/bin/zsh"
   )
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; evil-leader/set-key = spacemacs/set-leader-keys
  (spacemacs/set-leader-keys
    "." 'spacemacs/layouts-transient-state/body
    "$" 'spacemacs/workspaces-transient-state/body
    "l" nil
    "}" 'next-error
    "{" 'previous-error
    "wu" 'evil-window-right
    "wU" 'evil-window-move-far-right
    "wl" 'winner-undo
    "wL" 'winner-redo
    "Nn" 'evil-scroll-column-right
    "NN" 'evil-scroll-right
    "jc" 'avy-goto-line-above
    "jt" 'avy-goto-line-below
    "jh" 'avy-goto-word-or-subword-1
    "rh" 'helm-resume
    ;; SPC o reserved for user space
    "os" 'just-one-space
    "oc" 'evil-mc-mode
    "oo" 'avy-goto-char-in-line
    )
  ;; evil-insert-state-map
  ;; (define-key evil-insert-state-map (kbd "RET") 'newline-and-indent)
  ;; evil-normal-state-map
  ;; (define-key evil-normal-state-map (kbd "<kp-enter>") (kbd "%"))
  ;; (define-key evil-normal-state-map ",@" 'evil-record-macro)
  ;; (define-key evil-normal-state-map "q" nil)
  (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
  (define-key evil-normal-state-map (kbd "C-k") (kbd "4gk"))
  (define-key evil-normal-state-map (kbd "C-j") (kbd "4gj"))
  ;; (define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
  ;; (define-key evil-normal-state-map (kbd ",.") (kbd "C-^"))
  ;; (define-key evil-normal-state-map (kbd "<up>") (kbd "2gk"))
  ;; (define-key evil-normal-state-map (kbd "<down>") (kbd "2gj"))
  ;; (define-key evil-normal-state-map (kbd "<left>") (kbd "M-b"))
  ;; (define-key evil-normal-state-map (kbd "<right>") (kbd "M-f"))
  ;; evil-motion-state-map
  (define-key evil-motion-state-map (kbd "zu") 'evil-scroll-column-right)
  (define-key evil-motion-state-map (kbd "zU") 'evil-scroll-right)
  ;; (define-key evil-motion-state-map (kbd "zl") nil)
  ;; (define-key evil-motion-state-map (kbd "zL") nil)
  ;; evil-window-map
  (define-key evil-window-map "u" 'evil-window-right)
  (define-key evil-window-map "U" 'evil-window-move-far-right)
  ;; (define-key evil-window-map "l" 'evil-window-new)
  ;; (define-key evil-window-map "L" nil)
  ;; (define-key evil-window-map (kbd "C-S-n") 'evil-window-move-far-right)
  ;; (define-key evil-window-map (kbd "C-S-l") nil)
  ;; (define-key evil-insert-state-map (kbd "C-s") 'hippie-expand)
  ;; (define-key ac-completing-map "+" 'ac-next)
  ;; (define-key ac-completing-map (kbd "C-t") 'ac-next)
  ;; (setq evil-move-cursor-back nil)
  (with-eval-after-load 'company
    ;; "C-d" opens short description help window
    ;; (define-key company-active-map (kbd "C-n") 'company-select-next)
    ;; (define-key company-active-map (kbd "C-h") 'company-select-previous)
    (define-key company-active-map (kbd "C-h") 'company-complete-selection)
    ;; (define-key company-active-map (kbd "<kp-enter>") 'company-complete-selection)
    (define-key company-active-map (kbd "C-l") nil)
    )

  (setq
   scroll-margin 0
   scroll-conservatively 0
   ;; flycheck
   flycheck-gometalinter-deadline "15s"
   flycheck-gometalinter-disable-all t
   flycheck-gometalinter-enable-linters '("errcheck" "megacheck")
   ;; flycheck-indication-mode nil
   flycheck-indication-mode 'right-fringe
   ;; powerline
   powerline-default-separator 'alternate
   )

  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-buffers "TAGS")
    (add-to-list 'projectile-globally-ignored-files ".DS_Store")
    )

  ;; Disable smartparens highlighting
  ;; (with-eval-after-load 'smartparens
  ;;   (show-smartparens-global-mode -1))

  ;; Thanks StreakyCobra
  ;; (evil-set-initial-state 'term-mode 'emacs)
  ;; (evil-set-initial-state 'calculator-mode 'emacs)
  ;; (push 'term-mode evil-escape-excluded-major-modes)
  ;; (evil-define-key 'emacs term-raw-map (kbd "C-c") 'term-send-raw)

  (add-hook 'go-mode-hook 'go-guru-hl-identifier-mode)

  ;; (setq eclim-eclipse-dirs "~/eclipse/java-oxygen/Eclipse.app/Contents/Eclipse"
  ;;       ;; eclimd-executable "~/.p2/pool/plugins/org.eclim_2.7.2/bin/eclimd"
  ;;       eclim-executable "~/.p2/pool/plugins/org.eclim_2.7.2/bin/eclim")

  ;; Evil MC
  ;; (add-hook 'prog-mode-hook 'turn-on-evil-mc-mode)

  ;; Diminish not showing symbol's mode in modeline
  ;; (spacemacs|diminish hybrid-mode)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit-svn magit-popup git-commit ghub async with-editor dash kaolin-themes helm-rtags flycheck-rtags eziam-theme evil-goggles doom-themes company-rtags rtags clang-format zenburn-theme zen-and-art-theme yasnippet-snippets yapfify yaml-mode xterm-color ws-butler winum white-sand-theme which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toml-mode toc-org tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit symon sunny-day-theme sublime-themes subatomic256-theme subatomic-theme string-inflection stickyfunc-enhance srefactor spaceline-all-the-icons spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode shell-pop seti-theme scss-mode sass-mode reverse-theme restart-emacs rebecca-theme ranger rainbow-delimiters railscasts-theme racer pyvenv pytest pyenv-mode py-isort purple-haze-theme pug-mode protobuf-mode professional-theme popwin planet-theme pippel pipenv pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pcre2el password-generator paradox overseer orgit organic-green-theme org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme neotree naquadah-theme nameless mvn mustang-theme multi-term move-text monokai-theme monochrome-theme molokai-theme moe-theme mmm-mode minimal-theme meghanada maven-test-mode material-theme markdown-toc majapahit-theme magit-gitflow madhat2r-theme macrostep lush-theme lorem-ipsum livid-mode live-py-mode linum-relative link-hint light-soap-theme less-css-mode json-navigator js2-refactor js-doc jbeans-theme jazz-theme ir-black-theme insert-shebang inkpot-theme indent-guide importmagic impatient-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation heroku-theme hemisu-theme helm-xref helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme gruvbox-theme gruber-darker-theme groovy-mode groovy-imports grandshell-theme gradle-mode gotham-theme google-translate google-c-style golden-ratio godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md gandalf-theme fuzzy flyspell-popup flyspell-correct-helm flycheck-rust flycheck-pos-tip flycheck-gometalinter flycheck-bashate flx-ido flatui-theme flatland-theme fish-mode fill-column-indicator farmhouse-theme fancy-battery eyebrowse expand-region exotica-theme evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help ensime emmet-mode elisp-slime-nav editorconfig dumb-jump dracula-theme dockerfile-mode docker django-theme discover-my-major disaster diff-hl define-word dash-at-point darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme cython-mode cyberpunk-theme counsel-projectile company-web company-tern company-statistics company-shell company-quickhelp company-go company-emacs-eclim company-c-headers company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme clean-aindent-mode cherry-blossom-theme centered-cursor-mode cargo busybee-theme bubbleberry-theme browse-at-remote birds-of-paradise-plus-theme badwolf-theme auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes aggressive-indent afternoon-theme ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
