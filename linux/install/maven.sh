#!/bin/bash
## Description: Install Maven.

## HOW TO USE (as root):
# curl -sjkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/maven.sh | bash /dev/stdin
## OR
# bundle=maven3 bash -c 'curl -sjkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/maven.sh | bash /dev/stdin'


maven3=http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

[ -z $bundle ] && bundle='maven3'
[ -z $bundle_url ] && bundle_url=$(eval echo "\$${bundle}")

env_sh_filepath=/etc/profile.d/maven-env.sh
env_csh_filepath=/etc/profile.d/maven-env.csh


curl -sjkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin unzip

rm -rf /tmp/curl.tmp
curl -sjkLo /tmp/curl.tmp "${bundle_url}"

## tar.gz with one directory only inside
dirname=`zipinfo -1 /tmp/curl.tmp | egrep '^[^/]+/?$' | tail -1 | sed 's:/*$::'`

unzip -oqq /tmp/curl.tmp -d /opt
rm -rf /tmp/curl.tmp

export M2_HOME=/opt/${dirname}
export PATH=$PATH:$M2_HOME/bin
/bin/echo -e "\nexport M2_HOME=$M2_HOME\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv M2_HOME \"$M2_HOME\"\n" >> $env_csh_filepath

/bin/echo -e "\nexport PATH=\$PATH:$M2_HOME/bin\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv PATH \"\$PATH:$M2_HOME/bin\"\n" >> $env_csh_filepath

chmod 644 $env_sh_filepath $env_csh_filepath
