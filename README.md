# .dotfiles

My Arch Linux dotfiles.

## Fresh machine

Run `resources/setup` after you have copied your SSH keys to the machine. It
installs the base packages and paru, clones this repo, and configures the
system:

```sh
./resources/setup
```

The repo source is fixed to `git@github.com:tomimelo/.dotfiles.git`. If you
want to use your own fork, edit the clone URL in `resources/setup`.

## Manual steps

```sh
git clone git@github.com:tomimelo/.dotfiles.git
cd .dotfiles
export DEV_ENV=$PWD
./init      # dirs, wallpapers, submodules
./dev-env   # link configs
./run       # install packages (runs/*)
```

## Personalize git config and folders

`resources/setup` only personalizes the git identity and the projects folder:

```sh
GIT_NAME="Your Name" GIT_EMAIL=you@example.com DEV_USER=you ./resources/setup
```

It writes `~/.dotfiles-local-env`, which `.zsh_profile` sources to find your
projects folder. Machine-specific bits (monitors, audio devices) remain in
`env/.config/hypr/hyprland.conf` and `env/.zsh_profile`.