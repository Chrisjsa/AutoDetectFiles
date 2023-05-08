# AutoDetectFiles

This repository contains a Bash script `detect_files.sh` which monitors a source directory for the creation of specific files and moves them to a destination directory. The script can be configured either through a configuration file `config.cfg` or through command line arguments.

## Manual Usage

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

## Configuring detect_files.sh as a daemon service

To configure the detect_files.sh script as a daemon service on Linux, follow these steps:

1. Create a file called detect_files.service in the directory /etc/systemd/system/. You can use the text editor of your choice to create the file. For example, you can use nano:

```Bash
sudo nano /etc/systemd/system/detect_files.service
```

2. In the detect_files.service file, add the following content:

```
[Unit]
Description=File monitoring service
After=network.target

[Service]
ExecStart=/bin/bash /path/to/repo/AutoDetectFiles/detect_files.sh
Restart=always
User=current_user
Group=current_user
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=detect_files
Environment="DISPLAY=:0"

[Install]
WantedBy=multi-user.target
```

3. Save and close the file.

4. Reload the systemd configuration to recognize the new service file:

```Bash
sudo systemctl daemon-reload
```

5. Enable the service to automatically start on system boot:

```Bash
sudo systemctl enable detect_files.service
```

6. Start the service:

```Bash
sudo systemctl start detect_files.service
```
Now, the `detect_files.sh` script will automatically run on system boot and remain running as a daemon. It will also automatically restart in case of any errors.

7. Verify that the service is running

```Bash
sudo systemctl status detect_files.service
```

8. If you wish to stop the service

```Bash
sudo systemctl stop detect_files.service
```

## Notes

- When running the script as a service, make sure that the SOURCE_DIR and DEST_DIR parameters in the config.cfg file are defined with the full path to the corresponding directories. If the SOURCE_DIR and DEST_DIR parameters in the config.cfg file are not properly defined, the service may fail to start. In this case, you will need to stop and start the service again after correcting the configuration file.

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
