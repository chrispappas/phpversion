# phpversion

Easily handle per-directory php versions using a `.phpversion` file (like .nvmrc)

Uses a wrapper script called `php` that checks for the presence of a `.phpversion` file in the current directory 
in your terminal, and runs the args through that version, if available. 

## Usage

Place a `.phpversion` file with the simple numeric PHP version you want:

```
8.2
```

Supports PHP 7.4 and 8.0+, uses a simple regex

If the file is not present it will just run it through your system's default php interpreter.

## Installation

Option 1:

- Clone this repo
- Add a symlink from this repo's `phpversion.sh` named `php` to somewhere in your path (eg. `~/bin`)
- Example: `ln -s $(realpath ./phpversion.sh) ~/bin/php`

Option 2:
- Just copy the `phpversion.sh` file into somewhere early in your path (eg. `~/bin`) and name it `php`