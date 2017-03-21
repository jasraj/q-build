## q-build

> RPM and DEB packaging scripts for kdb+

This repo provides scripts to allow the standard kdb+ binary to built into RPM packages.

The repo also provides a default profile that will automatically set up `q`, once installed into the system (via the `/etc/profile.d` system).  

### RPM

The scripts within the `rpm` folder will generate the necessary [SPEC File](http://www.rpm.org/max-rpm/ch-rpm-inside.html) and source package before building the RPM. The generated RPM can then be installed on any system that supports RPM.

#### Prerequisites

1. Any Linux operating system that supports RPM as an install mechanism (e.g. RHEL, CentOS)
2. The `rpm-build` package installed
  * `yum install rpm-build`
3. A local copy of the kdb+ version you wish to package
  * If you don't have a licensed version locally, visit the [kx Webiste](http://kx.com/software-download.php) to download, and unzip, the 32-bit (`l32`) version
4. If you're planning to run the 32-bit version on a 64-bit machine, ensure that the 32-bit libraries are installed
  * `yum install glibc.i686`

#### Generating the kdb-plus RPM

1. Clone, or download, this repository on to your machine
2. Run `build.sh`
  * Example: `build.sh 3.1-2014.08.22 /path/to/kdb/home /custom/rpm/build/location`
  * Run `build.sh` with no arguments for usage information
3. The script will generate 3 files within the specified build location:
  * The SPEC file defines how to build the RPM
  * The source TAR GZ file that contains all the files that will be installed by the RPM
  * The RPM file itself 

The version and release number of the RPM that is generated is based on the kdb+ version passed into the `build.sh` script. 

#### Installing the kdb-plus RPM

In order to install the RPM into the default location (`/opt`) you must be able to run `sudo` as root. 

1. Run `sudo rpm -i /path/to/generated/kdb-plus.rpm`
  * If you don't have `sudo`, try `rpm -i --prefix=~/kdb-install /path/to/generated/kdb-plus.rpm`
2. Log out and log back in to pick up the new enviroment settings
  * Or just run `source /etc/profile.d/kdb-plus.sh`
3. Run `q` to start a q session!

#### Uninstalling the kdb-plus RPM

To uninstall, you need to query the name of kdb+ package that was installed before removing with `rpm -e *package_name*`:

```
[root ~]# rpm -qa | grep kdb
kdb-plus-3.1-2013.11.20
[root ~]# rpm -e kdb-plus-3.1-2013.11.20
[root ~]# rpm -qa | grep kdb
[root ~]#
```

[![Analytics](https://ga-beacon.appspot.com/UA-54104883-2/q-build/README)](https://github.com/jasraj/q-build)
[![Build](https://circleci.com/gh/jasraj/q-build.png?style=shield)](https://circleci.com/gh/jasraj/q-build)
