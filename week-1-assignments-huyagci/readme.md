## Project of the First Week

**_Built with;_**

[![Linux][#linux]][@linux] [![Bash][#bash]][@bash] [![Git][#git]][@git] [![VirtualBox][#virtualbox]][@virtualbox] [![Vagrant][#vagrant]][@vagrant]

#### :one: **Assignment**

> Backup home directories of all existing users in the system as a gzip archive and create an MD5 checksum of the archives every day at 11:05 PM with a log file of the last run time of the script.

#### :two: **Assignment**

> Create a script that checks the disk usage of partitions mounted on the root and build a warning system that sends a warning email to the specified user if the threshold is exceeded.

### **Table of Contents**

1. [Overview](#notebook_with_decorative_cover-overview)
2. [Features](#sparkles-features)
   - [Bootstrap Script](#bootstrap-script)
   - [Home Directory Backup Script](#home-directory-backup)
   - [Disk Usage Alert Script](#disk-usage-alerts)
3. [Usage](#gear-usage)
   - [Automated](#automated)
   - [Manual](#manual)
4. [Technologies](#computer-technologies)
5. [Directories](#open_file_folder-directories)

### :notebook_with_decorative_cover: **Overview**

This repository undertakes two projects developed under the [Patika.dev][@patika] & [Protein][@protein] DevOps Engineer Bootcamp as an assignment. It contains three scripts whose usage is mentioned below. `bootstrap.sh` is an initializer script that sets up the machine as instructed. `backup_home_dirs.sh` and `disk_usage_alert.sh` are the assignment scripts that are coded by the terms of the project.

### :sparkles: **Features**

#### _Bootstrap Script_

> - Sets the timezone of the machine as UTC+3 (Europe/Istanbul) and enables Network Time Protocol.
> - Downloads latest package information.
> - Installs sSMTP and mailutils.
> - Sets the sSMTP configuration as specified.
> - Writes cron jobs onto the system-wide crontab file.

#### _Home Directory Backup_

> - Takes the backup of all normal users in the system. (UID Range: 1000 - 60000)
> - Formats the name of the archives as "username--DD-MM-YYYY--MM-HH.tar.gz"
> - Creates the MD5 checksums of the archives in the same directory.
> - Will work every day @ 11:05 PM if you execute `bootstrap.sh`
> - Logs its last run time under `/tmp/logs/`

#### _Disk Usage Alerts_

> - Checks the disk space of `/` every minute if you execute `bootstrap.sh`
> - If the used space exceeds your defined threshold, the script will send you an email. (Default threshold is set to: 90%)
> - The email will contain the **partition name**, **machine name**, and **left space** information, as well as the **timestamp** of the execution.

### :gear: **Usage**

#### _Automated_

1. Install [VirtualBox][@virtualbox] and [Vagrant][@vagrant-download] to your machine _if you do not have them_.
2. Clone the project to your machine.
3. Open your CLI, change directory to project directory, and type `vagrant up`.
4. All the scripts will start running automatically and perform their commands.

#### _Manual_

1. Download the project files.
2. Copy all files under the `/shared/scripts/` to your environment.
3. Execute `bootstrap.sh` first to configure the machine settings.
4. Run the scripts manually from the directories that are stated [**below**](#open_file_folder-directories).

### :computer: **Technologies**

> - Linux :heart:
> - Bash Scripting
> - Git SCM
> - Oracle VM VirtualBox
> - Vagrant by HashiCorp

### :open_file_folder: **Directories**

```
Scripts & Configurations : /opt/scripts
Backup Archives          : /mnt/backups
MD5 Checksums            : /mnt/backups
Last Run Log             : /tmp/scripts
```

<!-- Badge Index -->

[#linux]: https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black
[#bash]: https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=GNU%20Bash&logoColor=white
[#git]: https://img.shields.io/badge/Git-E44C30?style=flat&logo=git&logoColor=white
[#virtualbox]: https://img.shields.io/badge/VirtualBox-183A61?style=flat&logo=virtualbox&logoColor=white
[#vagrant]: https://img.shields.io/badge/Vagrant-1868F2?style=flat&logo=vagrant&logoColor=white

<!-- URL Index -->

[@patika]: https://www.patika.dev/
[@protein]: https://protein.tech/
[@linux]: https://www.linux.org/
[@bash]: https://www.gnu.org/software/bash/
[@git]: https://git-scm.com/
[@virtualbox]: https://www.virtualbox.org/
[@vagrant]: https://www.vagrantup.com/
[@vagrant-download]: https://www.vagrantup.com/downloads/
