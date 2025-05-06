#!/bin/bash

echo "=================================================================================================================================="
echo "=================================================================================================================================="
echo "This is a Bash Shell script that converts and packages multiple Windows .ani cursors into installable Linux X11 cursors."
echo "The .ani conversion into usable XCursor file for linux is done by the 'win2xcur' tool by 'quantum5'."
echo "=================================================================================================================================="
echo "=================================================================================================================================="

echo "Enter the Directory of the .ani/.cur Windows cursors"
read -r input_dir

echo "Enter the Output Directory"
read -r output_dir

# Need to redo the logic for symbolic linkings. Maybe a new for loop for each similar cursors.
# Symbolic Links for cursors are obtained from Breeze cursors and modified slightly.
declare -a symbolic_links=(
  [0]="arrow left_ptr size-bdiag size-fdiag size-hor size-ver top_left_arrow"
  [1]="5c6cd98b3f3ebcb1f9c7f1c204630408 d9ce0ab605698f320427677b458ad60b left_ptr_help question_arrow whats_this"
  [2]="00000000000000020006000e7e9ffc3f 08e8e1c95fe2fc01f976f1e063a24ccd 3ecb610c1bf2410f44200f48c40d3599 half-busy left_ptr_watch"
  [3]="watch"
  [4]="cross tcross"
  [5]="ibeam xterm"
  [6]="draft"
  [7]="circle crossed_circle"
  [8]="3ecb610c1bf2410f44200f48c40d3599 n-resize ns-resize s-resize sb_v_double_arrow v_double_arrow"
  [9]="e-resize ew-resize h_double_arrow sb_h_double_arrow w-resize"
  [10]="nw-resize nwse-resize se-resize"
  [11]="ne-resize nesw-resize sw-resize"
  [12]="4498f0e0c1937ffe01fd06f973665830 9081237383d90e509aa00f00170e968f closedhand dnd-none fcf21c00b30f7e3f83fe0dfd12e71cff move"
  [13]="link"
  [14]="9d800788f1b08800ae810202380a0822 e29285e634086352946a0e7090d73106 hand1 hand2 pointing_hand"
)

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
    file=windows_names[$wincursor]
    if [[ -e $file ]]; then
      mv "$file" "${linux_names[$wincursor]}"
    else
      echo "File \"${windows_names[$wincursor]}\" not found"
    fi
    cd "$output_dir" || exit
  done
}

function symlinks() {
  echo "Creating symlinks for cursors"

  cd "$output_dir/cursors" || echo "Output path not found"
  for lincursor in "${!linux_names[@]}"; do
    ln -s "${linux_names[$lincursor]}" ${symbolic_links[$lincursor]}
  done
}

convert
cursor_rename
symlinks

echo "Finished."
