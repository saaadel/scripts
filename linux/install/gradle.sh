#!/bin/bash
## Description: Install Gradle.

## HOW TO USE (as root):
# curl https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/gradle.sh | bash /dev/stdin
## OR
# bundle=gradle3 bash -c 'curl https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/gradle.sh | bash /dev/stdin'


gradle3=https://services.gradle.org/distributions/gradle-3.2.1-bin.zip

[ -z $bundle ] && bundle='gradle3'
[ -z $bundle_url ] && bundle_url=$(eval echo "\$${bundle}")

env_sh_filepath=/etc/profile.d/gradle-env.sh
env_csh_filepath=/etc/profile.d/gradle-env.csh

yum install -y --setopt=tsflags=nodocs unzip
yum clean all
rm -rf /var/cache/yum/*

rm -rf /tmp/curl.tmp
curl -sjkLo /tmp/curl.tmp "${bundle_url}"

## tar.gz with one directory only inside
dirname=`zipinfo -1 /tmp/curl.tmp | egrep '^[^/]+/?$' | tail -1 | sed 's:/*$::'`

unzip -oqq /tmp/curl.tmp -d /opt
rm -rf /tmp/curl.tmp

export GRADLE_HOME=/opt/${dirname}
export PATH=$PATH:$GRADLE_HOME/bin
/bin/echo -e "\nexport GRADLE_HOME=$GRADLE_HOME\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv GRADLE_HOME \"$GRADLE_HOME\"\n" >> $env_csh_filepath

/bin/echo -e "\nexport PATH=\$PATH:$GRADLE_HOME/bin\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv PATH \"\$PATH:$GRADLE_HOME/bin\"\n" >> $env_csh_filepath

chmod 644 $env_sh_filepath $env_csh_filepath