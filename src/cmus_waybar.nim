import parseopt
import std/[strutils, osproc, json]

# TODO: Add nerd icon toggle
var nerd = false
var p = initOptParser()
for kind, key, val in p.getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
      of "nerd": nerd = true
  of cmdArgument:
    discard
  of cmdEnd: assert(false)

let run = execCmdEx("cmus-remote -Q")
if run.exitCode == 1:
  let output = %* {
    "class": "disconnected",
    "text": ""
  }
  echo output
  quit(0)
let details = run.output
var items = details.splitLines()

let status = items[0][7 .. ^1]
let outputStatus = (case status
                    of "playing": ""
                    of "paused": ""
                    else: "")
let playOptions = (case status
                   of "playing": "-u"
                   of "paused": "-p"
                   else: "")
# TODO:Add recusrive tag search for metadata, time elapsed and shuffle & repeat modes
var title: string
if "title" in items[5]:
  title = items[5][10 .. ^1]
elif "title" in items[6]:
  title = items[6][10 .. ^1]
let artist = items[4][11 .. ^1]

let output = %* {
  "text": outputStatus & "  " & artist & " - " & title,
  "class": status,
  "on-click": "cmus-remote " & playOptions,
  "tooltip": title &  " - " & artist
}

echo output
quit(0)
