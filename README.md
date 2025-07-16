# cmus waybar

A super light waybar module helper that shows the title of the current music playing and artist name with the playback status using nerd icon.

## Usage

- Install [Nim](https://nim-lang.org)
- Compile with `nimble build -d:release`
  - Optional: add to PATH
- Use in waybar config, if application not installed in path, replace with location of program:
  ```json
  custom/cmus": {
      "format": "{}",
      // "tooltip": true,
      "interval": 2,
      "exec": "cmus_waybar",
      "return-type": "json"
  }
  ```
- Use as waybar module

# License

This code is under MIT license
