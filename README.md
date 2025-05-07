# Windows to Linux Cursor Packager Script

This is a Bash shell script that facilitates conversion of Windows Cursors to Linux Cursors and packages them for installation into Linux (KDE and may apply to other DE) systems. The conversion of individual cursor files are done by the ['win2xcur'](https://github.com/quantum5/win2xcur) tool.

Custom Windows cursors mostly consists of 15 different individual cursors (Some may contain more. For more info refer to the [standard cursors for Windows](https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors)). Converting them into XCursor files (usable by Linux) is easy with a lot of tools already available. The hard part is that Linux uses more cursors files than Windows with different names. Fortunately most of them are just symbolic links to the corresponding cursor files from Windows. This script facilitates the conversion process, renaming of files and creating the symbolic links needed for Linux systems. An initial renaming though is needed for the Windows cursor files for this script to be able to work.

## Requirements

- ['win2xcur'](https://github.com/quantum5/win2xcur)

## Usage 

Rename the Windows cursor files as follows:

| Meaning | File Name |
|---------|-----------|
|Normal Select|normal.{ani,cur}|
|Help Select|help.{ani,cur}|
|Working in Background|working.{ani,cur}|
|Precision Select |crosshair.{ani,cur}|
|Text Select |text.{ani,cur}|
|Pen |pen.{ani,cur}|
|Unavailable |unavailable.{ani,cur}|
|Vertical Resize |vertical.{ani,cur}|
|Horizontal Resize|horizontal.{ani,cur}|
|Diagonal Resize 1 |diagonal1.{ani,cur}|
|Diagonal Resize 2|diagonal2.{ani,cur}|
|Move |move.{ani,cur}|
|Alternate Select |alternate.{ani,cur}|
|Link Select |link.{ani,cur}|

Note: Some custom cursors would have file names somewhat different from the Windows standard cursors naming scheme.

Take note of the directory path where the cursors are located and then run the script and follow the instructions within (Don't forget to make the script executable).

 ```
 $ ./CursorConvertPackage.sh 
 ```

To install the Cursor Package to the Linux system, the output folder (with the Cursor Name as the user assigned during the script) can be copied/moved into `/home/$USER/.local/share/icons` for user installation or `/usr/share/icons` for system wide installation. 
