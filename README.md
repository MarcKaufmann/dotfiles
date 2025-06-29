# dotfiles

This is largely built on a subset of [Bogdan Popa's dotiles](https://github.com/Bogdanp/dotfiles): 

## Setup 

1. Install [MacPorts](https://www.macports.org/)
    - Install Xcode manually first?
2. `sudo port install git`

## Tex/Latex

It may be that the current list of ports installed is not enough to get Latex working, in particular Beamer. In that case, check if the installing the following additional ports helps:

- texlive-basic 
- texlive-bibtex-extra 
- texlive-bin 
- texlive-common 
- texlive-fonts-extra 
- texlive-fonts-recommended 
- texlive-latex 
- texlive-latex-extra 
- texlive-latex-recommended 
- texlive-math-science 
- texlive-pictures 
- texlive-plain-generic 

## Manual Checklist

- Map capslock to Ctrl
- Install 1Password and browser extension
- pinboard browser extension: 
    - pull up the [pinboard bookmarklet](https://pinboard.in/howto/) to the bookmarks toolbar, which has to be visible
- Install RStudio
- Install Racket
- Remap Capslock to Ctrl
- Install 1Password

## todo

- Install Doom Emacs
    - Much of that can be automated, once there is no bug anymore
- Move all my repositories to GitHub. Stop having duplicates across github and gitlab.
    - Obviously back them up regularly to my server
- Clone repositories
- Create repo for new dotfiles on github. Remove old one probably.
- Install Doom Emacs and configure (ESS modes etc)
- Install latex
- Configure tmux
- Install Anki
