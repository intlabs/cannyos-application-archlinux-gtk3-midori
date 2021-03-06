## CannyOS ArchLinux with GTK3


This repository contains the *Dockerfile* and *associated files* for setting up a container with ArchLinux and GTK3 for CannyOS

### Dependencies

* docker


### Installation

1. Install [Docker](https://www.docker.io/).

2. You can then build the container set from the via entering:

	Manual building can be done with the following:
	`sudo docker build -t="intlabs/cannyos-application-archlinux-gtk3-midori" github.com/intlabs/cannyos-application-archlinux-gtk3-midori`

	Two stage building should not be required but is avaliblible via:
	`bash <(curl -s https://raw.githubusercontent.com/intlabs/cannyos-application-archlinux-gtk3-midori/master/Build.sh)`

	
### Usage

* this will run and drop you into a session with privileges to run FUSE:

`docker run -i -t -d  --privileged=true --lxc-conf="native.cgroup.devices.allow = c 10:229 rwm"  --volume "/CannyOS/build/cannyos-application-archlinux-gtk3-midori":"/CannyOS/Host"  --name "cannyos-application-archlinux-gtk3-midori"  --user "root"  -p 80 intlabs/cannyos-application-archlinux-gtk3-midori`
