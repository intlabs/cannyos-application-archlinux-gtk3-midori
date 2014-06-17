#
# CannyOS ArchLinux container with midori
#
# https://github.com/intlabs/cannyos-application-archlinux-gtk3-midori
#
# Copyright 2014 Pete Birley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Pull base image.
FROM intlabs/cannyos-base-archlinux-gtk3

# Set environment variables.
ENV HOME /root

# Set the working directory
WORKDIR /

#****************************************************
#                                                   *
#         INSERT COMMANDS BELLOW THIS               *
#                                                   *
#****************************************************

# Install midori
RUN pacman -Sy --noconfirm && \
	curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz && \
	tar zxvf package-query.tar.gz && \
	cd package-query && \
	pacman -Sy --noconfirm binutils && \
	pacman -Sy --noconfirm base-devel gobject-introspection && \
	makepkg -s --asroot --noconfirm && \
	pacman --noconfirm -U *.xz && \
	curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz && \
	tar zxvf yaourt.tar.gz && \
	cd yaourt && \
	makepkg -si --asroot --noconfirm && \
	sudo pacman  --noconfirm -U *.xz && \
	yaourt -S --noconfirm midori-gtk3

# Make dir for dbus
RUN mkdir -p /var/run/dbus

#****************************************************
#                                                   *
#         ONLY PORT RULES BELLOW THIS               *
#                                                   *
#****************************************************

#HTTP (broadway)
EXPOSE 80/tcp

#****************************************************
#                                                   *
#         NO COMMANDS BELLOW THIS                   *
#                                                   *
#****************************************************

#Add startup & post-install script
ADD CannyOS /CannyOS
WORKDIR /CannyOS
RUN chmod +x *.sh

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT ["/CannyOS/startup.sh"]