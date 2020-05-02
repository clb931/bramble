#!/bin/bash



#check for cgroups and add them is needed
cpuset_enable=false
memory_enable=false
memory_set=false
update=false

istr=$( cat /boot/cmdline.txt )
for item in $istr ; do
    if [ $item = "cgroup_enable=cpuset" ] ; then
	cpuset_enable=true
	update=true
    elif [ $item = "cgroup_enable=memory" ] ; then
	memory_enable=true
	update=true
    elif [ $item = "cgroup_memory=1" ]; then
	memory_set=true
	update=true
    fi
done



ostr="${istr}"
if [ "$cpuset_enable" = false ] ; then
    echo "cgroup_enable=cputset updated"
    ostr="${ostr} cgroup_enable=cpuset"
else
    echo "cgroup_enable=cputset up to date"
fi

if [ "$memory_set" = false ] ; then
    echo "cgroup_memory=1 updated"
    ostr="${ostr} cgroup_memory=1"
else
    echo "cgroup_memory=1; up to date"
fi

if [ "$memory_enable" = false ] ; then
    echo "cgroup_enable=memory updated"
    ostr="${ostr} cgroup_enable=memory"
else
    echo "cgroup_enable=memory up to date"
fi

if [ ! "$ostr" = "$istr" ] ; then
    echo "${ostr}" > /boot/cmdline.txt
fi






# check for k3s and install if it isn't there
if command -v k3s >/dev/null 2>&1; then
    echo "found k3s"
else
    echo "installing k3s"
    curl -sfL https://get.k3s.io | sh -
fi
