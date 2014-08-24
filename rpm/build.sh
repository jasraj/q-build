#!/usr/bin/env bash

## RPM Spec Builder for kdb+
## Copyright (C) 2014 Jaskirat M.S. Rajasansir
## License BSD, see LICENSE for details

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))

readonly KDB_VERSION=$1
readonly KDB_FOLDER_ROOT=$2
readonly RPM_BUILD_LOC=$3


readonly DEFAULT_KDB_FOLDER_ROOT=~/temp/q
readonly DEFAULT_RPM_BUILD_LOC=~/rpmbuild

readonly KDB_STAGING_FOLDER=$(mktemp -d)


set -eu

main()
{
    echoInf "\n*** RPM Spec Builder for kdb+ ***\n"

    if [[ $KDB_VERSION == "" ]]; then
        usage
        exit 1
    fi

    export IFS='-'
    local kdb_version_array=($KDB_VERSION)
    local kdb_version_array_count=${#kdb_version_array[@]}
    unset IFS

    if [[ $kdb_version_array_count -ne 2 ]]; then
        usage
        exit 2
    fi

    local kdb_major_version=${kdb_version_array[0]}
    local kdb_minor_version=${kdb_version_array[1]}

    if [[ $KDB_FOLDER_ROOT == "" ]]; then
        local kdb_root=$DEFAULT_KDB_FOLDER_ROOT
    else
        local kdb_root=$KDB_FOLDER_ROOT
    fi

    if [[ $RPM_BUILD_LOC == "" ]]; then
        local build_loc=$DEFAULT_RPM_BUILD_LOC
    else
        local build_loc=$RPM_BUILD_LOC
    fi


    local app_name=kdb-plus-${KDB_VERSION}
    local app_path=kdb-plus-${kdb_major_version}
    local source_target=${build_loc}/SOURCES/${app_name}.tar.gz
    local spec_target=${build_loc}/SPECS/${app_name}.spec

    echoInf "\tKDB Version:\t$KDB_VERSION"
    echoInf "\tKDB Folder:\t$kdb_root"
    echoInf "\tRPM Location:\t$build_loc"

    echoInf "\n$(date) Building kdb TAR GZ ($KDB_STAGING_FOLDER/$app_path)\n"

    pushd $KDB_STAGING_FOLDER > /dev/null
    mkdir $app_name
    cp -r ${kdb_root} ./$app_path
    cp ${PROGDIR}/kdb-plus.profile ./$app_path
    echo "$KDB_VERSION" > ./$app_path/VERSION
    sed -i "s|~~INSTALL_PATH~~|/opt/kdb-plus/$app_path|g" ./${app_path}/kdb-plus.profile
    tar -cvzh -f $source_target ./$app_path

    echoInf "\n$(date) Generating SPEC file...\n"

    cp -f ${PROGDIR}/kdb-plus.spec $spec_target

    sed -i "s/~~VERSION~~/$kdb_major_version/g" $spec_target
    sed -i "s/~~RELEASE~~/$kdb_minor_version/g" $spec_target

    find ./$app_path -type d | awk ' { print "install -m 755 -d ." $1 " %{buildroot}/opt/kdb-plus/" $1 }' >> $spec_target
    find ./$app_path -type f | grep -v '/q$' | awk ' { print "install -m 644 ." $1 " %{buildroot}/opt/kdb-plus/" $1 }' >> $spec_target
    find ./$app_path -type f | grep '/q$' | awk ' { print "install -m 755 ." $1 " %{buildroot}/opt/kdb-plus/" $1 }' >> $spec_target


    popd > /dev/null

}

usage()
{
cat >&2 <<- EOF
Usage:
   
    $PROGNAME *KDB_VERSION* *KDB_FOLDER_ROOT* *RPM_BUILD_LOC*

        *KDB_VERSION*     :
        *KDB_FOLDER_ROOT* : The folder containing the kdb binary and associated files for building. Defaults to ${DEFAULT_KDB_FOLDER_ROOT}.
        *RPM_BUILD_LOC*   :

EOF
}

echoInf()
{
    echo -e "$*"
}

echoErr()
{
    echo -e "$*" >&2
}

exitCleanup()
{
    rm -rf $KDB_STAGING_FOLDER
}

trap exitCleanup EXIT


main

