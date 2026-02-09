# Clipboard Stack
This lets you use your clipboard as stack memory. It is made in [AutoHotKey V1](https://www.autohotkey.com/). 

## Installation
I have provided an executable ([click to download](https://github.com/SP4CEBARsystems/clipboard-stack/releases/download/v1.0.0/clipboard.stack.exe)) for this macro that you can download and run if you trust me. I have to note that most AHK macros are flagged as trojans by some security vendors on [VirusTotal](https://www.virustotal.com), [here is the VirusTotal report for this executable](https://www.virustotal.com/gui/file/e4d28746f0c91afd3e47c7e207934aef4d798de5f9c902ea19368aeed3e8b6fc?nocache=1). If you don't trust me, [review the code](https://github.com/SP4CEBARsystems/clipboard-stack/blob/main/clipboard%20stack.ahk), download AutoHotKey V1 ([click to download](https://www.autohotkey.com/download/ahk-install.exe)), and [compile your own executable](https://www.autohotkey.com/docs/v1/Scripts.htm#ahk2exe-run). If you don't trust AutoHotKey check out [this report](https://safeweb.norton.com/report/show?url=autohotkey.com%2Fdownload).

## Stopping The Macro
When an AHK macro is running, you can stop it from its tray icon.

## Controls
- The tool will monitor the clipboard and automatically push any changes to the stack.
- `ctrl` + `v` to paste from the clipboard stack.
- `alt` + `v` to pop from the clipboard stack and paste.
