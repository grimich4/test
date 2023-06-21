#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

touch find.out myfind.out

check()
{
    printf "${BLUE}________________________NEW_TEST________________________${NC}\n"
    echo test\: "$@"

    which $@ 2> find.out
    find_return_code=$?

    ./which2.sh $@ 2> myfind.out
    myfind_return_code=$?

    echo -n "exit_code: "
    [ $find_return_code -eq $myfind_return_code ] && printf "$GREEN[OK]$NC\n" || printf "$RED[KO]$NC\n"

    diff -u find.out myfind.out
    output_diff=$?
    echo -n "stdout: "
    [ $output_diff -eq 0 ] && printf "$GREEN[OK]$NC\n" || printf "$RED[KO]$NC\n"
}

check gcc
check -a gcc
check -d gcc
check gcc curl which
check -a gcc curl which
check -d gcc curl which
check gcc curl which dontexist
check -a gcc curl which dontexist
check -d gcc curl which dontexist
check gcc curl -a which
check -a gcc curl -a which
check -d gcc curl -a which
check dontexist

# rm find.out myfind.out