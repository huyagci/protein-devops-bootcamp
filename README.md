# Protein DevOps Engineer Bootcamp

## Project of the Second Week

**_Built with;_**

[![Linux][#linux]][@linux] [![Bash][#bash]][@bash] [![Git][#git]][@git] [![VirtualBox][#virtualbox]][@virtualbox] [![Vagrant][#vagrant]][@vagrant]

#### :hash: **Assignment**

> Create a bash script that helps the developer to build a project[^1] on a specified branch in a working git repository.

**Script has to be able to ;**

> - Switch between branches and build from a given branch upon user requests.
> - Warn the user if the branch is main or master.
> - Create a new branch upon user requests.
> - Enable/disable debug mode of maven. _(Default must be disabled)_
> - Allow users to specify the compressed archive format as "zip" or "tar.gz" formats. _(Default must be "tar.gz")_
> - Terminate if any other compressed algorithms are given. _(Must use the default if not specified)_
> - Set the archive name as the selected branch name.
> - Set the output directory for compressed archives upon user requests. _(Default must be the working directory)_

### **Table of Contents**

1. [Overview](#notebook_with_decorative_cover-overview)
2. [Features](#sparkles-features)
   - [Bootstrap Script](#bootstrap-script)
   - [Git Helper Script](#git-helper)
   - [Build Helper Script](#build-helper)
3. [Installation](#gear-installation)
   - [Automated](#automated)
   - [Manual](#manual)
4. [Usage](#wrench-usage)
   - [Parameters](#parameters)
5. [Technologies](#computer-technologies)
6. [Directories](#open_file_folder-directories)

### :notebook_with_decorative_cover: **Overview**

This repository contains an assignment project developed under the [Patika.dev][@patika] & [Protein][@protein] DevOps Engineer Bootcamp. `bootstrap.sh` is an initializer script that sets up the machine as instructed. `git_helper.sh` is an auxiliary script to manage multiple git instances and was originally not a part of the assignment. `build_helper.sh` is the main script that is coded by the terms of the project.

### :sparkles: **Features**

#### _Bootstrap Script_

> - Sets the timezone of the machine as UTC+3 (Europe/Istanbul) and enables Network Time Protocol.
> - Downloads the latest package information.
> - Downloads, installs, and configures Java 18, Apache Maven 3.8.5 , and the latest version of Git SCM.
> - Sets the environment variables for the stated technologies above.
> - Sets the permissions of the script files.
> - Defines system-wide aliases for the scripts for easy use.

#### _Git Helper_

> - The main goal of this script is to assist the `Build Helper Script` by managing multiple git repositories simultaneously.
> - Searches for all initialized git repositories under the project directory.
> - Can terminate all git repositories at the same time.
> - Can initialize git instances for all directories under the project directory simultaneously.

#### _Build Helper_

> - Manages git and maven package manager to fulfill the tasks given by the user.
> - Switches between branches and build the project depending on the user requests.
> - Warns the user if the branch is main or master.
> - Creates a new branch and build the project from it if specified.
> - Enables or disables maven debug mode and quiet mode. Also can skip tests.
> - Can create compressed artifacts of the project as "zip" or "tar.gz" formats.
> - Renames the archive files as `branchName.zip` or `branchName.tar.gz` automatically.
> - Sets output directory to user-specified directory.
> - Cleans the target directory of the maven project.

### :gear: **Installation**

##### _Automated_

1. Install [VirtualBox][@virtualbox] and [Vagrant][@vagrant-download] to your machine _if you do not have them_.
2. Clone the project to your machine.
3. Open your CLI, change directory to project directory, and type `vagrant up`.
4. Vagrant will configure the virtual machine first then you may test the project.

##### _Manual_

1. Download all of the project files.
2. Copy all scripts under the `/shared/scripts` and sample project from `/shared/project/java` to your environment.
3. Execute `bootstrap.sh` first to configure the machine settings.
4. Run the scripts with the aliases configured or manually from the directories that are stated [**below**](#open_file_folder-directories).

### :wrench: **Usage**

- Built-in aliases are `githelper` and `buildhelper`. You may execute the scripts with the aliases if you executed `bootstrap.sh` first.
- Optionally, you may call the scripts from any directory with an acceptable arguments that are stated below.
- The target directory of _Git Helper_ scripts is `/opt/project` directory.
- The target directory of _Build Helper_ scripts is `/opt/project/java` directory.
- You can change these settings by re-defining the `TARGET_DIR` variable within the scripts.

##### _Parameters_

```bash
OPTIONS:    ARGUMENTS:         DESCRIPTION:                             DEFAULT VALUE:

[-b]        <branch_name>      Branch name to get the build from.       Current Branch
[-f]        <zip|tar.gz>       Compress format of the artifact.         tar.gz
[-p]        <artifact_path>    Output path of compressed artifacts.     Current Directory
[-n]        <new_branch>       Creates a new branch if applied.

[-q]        <true|false>       Enable or disable quiet mode.            Enabled
[-d]        <true|false>       Enable or disable debug mode.            Disabled
[-t]        <true|false>       Apply or skip tests.                     Skip

[-c]                           Cleans the maven project if applied.
[-h]                           Shows usage/help.
```

### :computer: **Technologies**

> - Linux
> - Bash Scripting :heart:
> - Git SCM
> - Oracle VM VirtualBox
> - Vagrant by HashiCorp

### :open_file_folder: **Directories**

```
Scripts             : /opt/scripts
Project Samples     : /mnt/project
```

<!-- View Counter -->
<p align="right"><img src="https://komarev.com/ghpvc/?username=testing143&style=flat&label=Views&color=blue" alt="View Counter"></a></p>

<!-- Footnotes -->

[^1]: Java Spring Boot with Maven Package Manager is provided as a sample project and the script is built upon this configuration. (Can be modified to any other project)

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
