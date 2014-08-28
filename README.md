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
3. A local copy of the kdb+ version you wish to package. If you don't have a licensed version, visit the [kx Webiste](http://kx.com/software-download.php) to download the 32-bit `l32` version which is free for commerical use.

#### Generating the kdb-plus RPM

1. Clone, or download, this repository on to your machine
2. Run `build.sh`
  * Example: `build.sh 3.1-2014.08.22 /path/to/kdb/home /custom/rpm/build/location`
  * Run `build.sh` with no arguments for usage information
3. The script will then generate:
  * SPEC file in `*RPM_BUILD_LOC*/SPECS`
  * Source .tar.gz in `*RPM_BUILD_LOC*/SOURCES`
  * RPM file in `*RPM_BUILD_LOC*/RPMS`

#### Installing the kdb-plus RPM

### DEB

#### Prerequisites

#### Generating the kdb-plus DEB

#### Installing the kdb-plus DEB


[![Analytics](https://ga-beacon.appspot.com/UA-54104883-2/q-build/README)](https://github.com/jasraj/q-build)
