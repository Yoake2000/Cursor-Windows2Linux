#!/bin/bash

echo "=================================================================================================================================="
echo "=================================================================================================================================="
echo "This is a Bash Shell script that converts and packages multiple Windows .ani cursors into installable Linux X11 cursors."
echo "The conversion into usable XCursor file for linux is done by the 'win2xcur' tool by 'quantum5'."
echo "=================================================================================================================================="
echo "=================================================================================================================================="

read -r "Enter the Name for this Cursor Package" Package_name

read -r "Enter a description for the Cursor Package" Package_desc

read -r "Enter the Directory of the .ani/.cur Windows cursors" input_dir

read -r "Enter the Output Directory" output_dir

output_dir="$output_dir"/"$Package_name"

# Symbolic Links for cursors are obtained from Breeze cursors and modified slightly.
symbolic0=("arrow" "left_ptr size-bdiag" "size-fdiag" "size-hor" "size-ver" "top_left_arrow")
symbolic1=("5c6cd98b3f3ebcb1f9c7f1c204630408" "d9ce0ab605698f320427677b458ad60b" "left_ptr_help" "question_arrow" "whats_this")
symbolic2=("00000000000000020006000e7e9ffc3f" "08e8e1c95fe2fc01f976f1e063a24ccd" "3ecb610c1bf2410f44200f48c40d3599" "half-busy" "left_ptr_watch")
symbolic3=("watch")
symbolic4=("cross" "tcross")
symbolic5=("ibeam" "xterm")
symbolic6=("draft")
symbolic7=("circle" "crossed_circle")
symbolic8=("3ecb610c1bf2410f44200f48c40d3599" "n-resize" "ns-resize" "s-resize" "sb_v_double_arrow" "v_double_arrow")
symbolic9=("e-resize" "ew-resize" "h_double_arrow" "sb_h_double_arrow" "w-resize")
symbolic10=("nw-resize" "nwse-resize" "se-resize")
symbolic11=("ne-resize" "nesw-resize" "sw-resize")
symbolic12=("4498f0e0c1937ffe01fd06f973665830" "9081237383d90e509aa00f00170e968f" "closedhand" "dnd-none" "fcf21c00b30f7e3f83fe0dfd12e71cff" "move")
symbolic13=("link")
symbolic14=("9d800788f1b08800ae810202380a0822" "e29285e634086352946a0e7090d73106" "hand1" "hand2" "pointing_hand")

symbolic=("symbolic0" "symbolic1" "symbolic2" "symbolic3" "symbolic4" "symbolic5" "symbolic6" "symbolic7" "symbolic8" "symbolic9" "symbolic10" "symbolic11" "symbolic12" "symbolic13" "symbolic14")

declare -a linux_names=(
  [0]="default"
  [1]="help"
  [2]="progress"
  [3]="wait"
  [4]="crosshair"
  [5]="text"
  [6]="pencil"
  [7]="not-allowed"
  [8]="size_ver"
  [9]="size_hor"
  [10]="size_fdiag"
  [11]="size_bdiag"
  [12]="dnd-move"
  [13]="up-arrow"
  [14]="pointer"
)

declare -a windows_names=(
  [0]="normal"
  [1]="help"
  [2]="working"
  [3]="busy"
  [4]="crosshair"
  [5]="text"
  [6]="handwriting"
  [7]="unavailable"
  [8]="vertical"
  [9]="horizontal"
  [10]="diagonal1"
  [11]="diagonal2"
  [12]="move"
  [13]="alternate"
  [14]="link"
)

function convert() {
  echo "Converting .ani/.cur cursors"
  mkdir -p "$output_dir/cursors"
  win2xcur "$input_dir"/*.ani -o "$output_dir/cursors"
  win2xcur "$input_dir"/*.cur -o "$output_dir/cursors"
}

function cursor_rename() {
  echo "Renaming converted cursors into XCursor file names"

  cd "$output_dir/cursors" || echo "Output path not found"
  for wincursor in "${!windows_names[@]}"; do
    file="${windows_names[$wincursor]}"
    if [[ -e "$file" ]]; then
      mv "$file" "${linux_names[$wincursor]}"
    else
      echo "File \"${windows_names[$wincursor]}\" not found"
    fi
  done
}

function symlinks() {
  echo "Creating Symbolic links for cursors"

  cd "$output_dir/cursors" || echo "Output path not found"
  for lincursor in "${!linux_names[@]}"; do
    declare -n symboliclink="${symbolic[$lincursor]}"
    for symlink in "${!symboliclink[@]}"; do
      ln -s "${linux_names[$lincursor]}" "${symboliclink[$symlink]}"
    done
  done
}

function index_maker() {
  cd "$output_dir" || exit
  touch index.theme
  (
    echo "[Icon Theme]"
    echo "Name=$Package_name"
    echo "Comment=$Package_desc"
  ) >>index.theme
}

convert
cursor_rename
symlinks
index_maker

echo "Finished."
