# My Powershell environment

I'd like to be able to wipe my machine often. I don't like spending time setting it up to my liking. This tool aims to create a consistent and reproducable powershell environment tuned for development.

## Install

Choco packages are defined in *dev.json*, pass it in to the installer (requires admin powershell):

```powershell
.\install.ps1 .\config\dev.json
```

## Features

### Tab completion

The default powershell tab completion is overridden to provide recursive file and directory search.

![Tab completion animation](./assets/tabcompletion.gif)

*Notice CPU usage on the first 'tab' keystroke - it utilizes all available resources for the fastest file search.*

---

### Auto install

The following tools are automatically installed, with aliases (shortcuts) for easy access:

* Visual Studio Code (shortcut: 'vs')
* Notepad++ (shortcut: 'sn', as in 'Show Notepad')
* See full list in [dev.json](.\config\dev.json)

---

### Prompt

Nothing spectacular, here is what is preconfigured:

* Git status - uses posh-git module, installed and preconfigured for convenience.
* Timestamp - useful when you trigger long running command, but forget to time it.
* Duration - since this prompt is not trivial, it is important to actually track the time it took to generate the prompt.
