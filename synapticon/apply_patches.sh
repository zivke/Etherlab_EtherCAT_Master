#!/usr/bin/env bash
#
# Simple script which takes the path to the folder for the official patchset
# and a patchlist file. no checks happen here, so if the patchset does not
# apply to the checked out upstream you have to figure out manually what is
# going on.

set -e

debug () {
    [ -n "${DEBUG}" ] && echo "[DEBUG] $1"
}

print_usage () {
    echo "${0/.*\//} <path/to/uecasm/directory> <path/to/patchlist>"
}

if [ $# -lt 2 ]
then
    print_usage
    exit 1
fi

BASEDIR=$( git rev-parse --show-toplevel )
GITCMD="git -C ${BASEDIR}"
PATCHDIR=$1
PATCHLIST=$2

debug "Value of BASEDIR = $BASEDIR"
debug "Value of PATCHDIR = $PATCHDIR"
debug "Value of PATCHLIST = $PATCHLIST"

if [ ! -d ${PATCHDIR} ]
then
    echo "ERROR could not find ${PATCHDIR}"
    echo "Please make sure the unoffcial patchset is installed there."
    exit 1
fi

if [ ! -f ${PATCHLIST} ]
then
    echo "ERROR could not find ${PATCHLIST}"
    echo "Please enter the path to the file containing the patch list."
    exit 1
fi

# Apply the listed patches in PATCHLIST, if something goes wrong then `set -e`
# will break this script.
while read line
do
    [[ "${line}" =~ ^\#.* ]] && continue
    echo "Apply patch ${line}"
    git -C ${BASEDIR} am ${PATCHDIR}/${line}
done < ${PATCHLIST}

exit 0

# vim: set ts=4 sw=4 expandtab ai:
