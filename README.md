# AutoDetectFiles

This repository contains a Bash script `detect_files.sh` which monitors a source directory for the creation of specific files and moves them to a destination directory. The script can be configured either through a configuration file `config.cfg` or through command line arguments.

## Usage

To use the script, follow these steps:

1. Clone the repository to your local machine.
2. Install `inotify-tools` on your system. This is necessary for the script to work properly. On Debian-based systems, you can install it with the following command:

```Bash
sudo apt-get install inotify-tools
```

3. Open a terminal and navigate to the cloned repository.
4. Modify `config.cfg` to suit your needs. The configuration file contains the following parameters:

* `SOURCE_DIR`: the source directory to monitor.
* `DEST_DIR`: the destination directory to move the files to.
* `FILES`: a list of filenames to monitor for creation events.

5. If you prefer to configure the script through command line arguments, run the following command:

```Bash
./detect_files.sh <source_dir> <dest_dir> <file1> <file2> ...
```
    Replace <source_dir> with the source directory, <dest_dir> with the destination directory, and <file1> <file2> ... with the list of filenames to monitor.

6. If you prefer to use the configuration file, simply run the following command:

```Bash
./detect_files.sh
```

7. The script will start monitoring the source directory for file creation events. When a file is created with a filename that matches one of the filenames in the FILES list, the script will move it to the destination directory. If the file already exists in the destination directory, it will be overwritten.

## Notes

- The script uses the inotifywait command to monitor the source directory for file creation events. This command is not available on all systems, so the script may not work on all machines.
- The script assumes that the directory structure is as follows:
```
.
├── config.cfg
├── detect_files.sh
├── destination
└── source
    ├── file1.txt
    ├── file2.png
    ├── file3.jpg
    └── file.zip
```
    If your directory structure is different, you will need to modify the SOURCE_DIR and DEST_DIR parameters accordingly.
- The script does not monitor subdirectories within the source directory.