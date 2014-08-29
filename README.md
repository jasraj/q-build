## q-build

> RPM and DEB packaging scripts for kdb+

This repo provides scripts to allow the standard kdb+ binary to built into the following package types:

* RPM (for RedHat systems)
* DEB (for Debian systems, including Ubuntu)

The repo also provides a default profile that will automatically set up `q`, once installed into the system (via the `/etc/profile.d` system).  

### RPM

The scripts within the `rpm` folder will generate the necessary [SPEC File](http://www.rpm.org/max-rpm/ch-rpm-inside.html) and source package before building the RPM. The generated RPM can then be installed on any system that supports RPM.

#### Prerequisites

1. A machine running Red Hat Enterprise Linux (RHEL) or other RPM-based Operating System
2. The `rpm-build` package installed (`yum install rpm-build` should install it on an RHEL system)
3. A local copy of the kdb+ version you wish to package
  * If you don't have a licensed version, visit the [kx Webiste](http://kx.com/software-download.php) to download, and unzip, the 32-bit `l32` version which is free for commerical use

#### Generating the kdb-plus RPM

1. Clone, or download, this repository on to your machine
2. In order to build the RPM as a non-root user (which is *highly* recomended):
  * `echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros`
3. Run `build.sh`
  * Example: `build.sh 3.1-2014.08.22 /path/to/kdb/home /custom/rpm/build/location`
  * Run `build.sh` with no arguments for usage information
4. The script will generate 3 files:
  * The SPEC file defines how to build the RPM
    * Location: `*RPM_BUILD_LOC*/SPECS`
  * The source TAR GZ file that contains all the files that will be installed by the RPM
    * Location: `*RPM_BUILD_LOC*/SOURCES`
  * The RPM file itself 
    * Location: `*RPM_BUILD_LOC*/RPMS/*ARCH*`

The version and release number of the RPM that is generated is based on the kdb+ version passed into the `build.sh` script. 

#### Installing the kdb-plus RPM

In order to install the RPM into the default location (`/opt`) you must be able to run `sudo` as root. 

1. Run `sudo rpm -i /path/to/generated/kdb-plus.rpm`
  * If you don't have `sudo`, try `rpm -i --prefix=~/kdb-install /path/to/generated/kdb-plus.rpm`
2. Log out and log back in to pick up the new enviroment settings
  * `echo $QHOME` or `echo $PATH` to check that kdb+ has been installed
3. Run `q` to start a q session!

#### Uninstalling the kdb-plus RPM

1. Get the name of the kdb-plus package
  * `rpm -qa | grep kdb-plus`
2. Uninstall the package
  * `rpm -e *installed_package_name*

### DEB

#### Prerequisites

#### Generating the kdb-plus DEB

#### Installing the kdb-plus DEB


[![Analytics](https://ga-beacon.appspot.com/UA-54104883-2/q-build/README)](https://github.com/jasraj/q-build)
