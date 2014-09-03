#!/usr/bin/env bash

## Profile for kdb+
## Copyright (C) 2014 Jaskirat M.S. Rajasansir
## License BSD, see LICENSE for details

if [[ -z $KDB_INSTALL_PATH ]]; then
    # Allows profile to be re-sourced without error
    readonly KDB_INSTALL_PATH=~~INSTALL_PATH~~
fi

main()
{
    if [[ $KDB_INSTALL_PATH == "" ]]; then
        echo "ERROR: kdb+ path has not been specified." >&2
    fi

    if [[ ! -d $KDB_INSTALL_PATH ]]; then
        echo "ERROR: kdb+ path ($KDB_INSTALL_PATH) does not exist." >&2
    fi

    export QHOME=$KDB_INSTALL_PATH

    local PC_ARCH=$(uname -i)

    if [[ $PC_ARCH == "x86_64" ]] && [[ -d ${KDB_INSTALL_PATH}/l64 ]]; then
        export PATH=$PATH:${KDB_INSTALL_PATH}/l64
    else
        export PATH=$PATH:${KDB_INSTALL_PATH}/l32
    fi
}

main

