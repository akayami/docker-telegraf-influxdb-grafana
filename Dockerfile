FROM archlinux:latest

RUN pacman -Sy gawk --noconfirm
RUN rm -fr /etc/pacman.d/gnupg
RUN pacman-key --init
RUN pacman-key --populate archlinux

RUN pacman -Syu --noconfirm
RUN pacman -S wget binutils fakeroot sudo git go base-devel --noconfirm

RUN echo "Defaults	lecture=\"never\"" >> /etc/sudoers
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#RUN pacman -S nodejs yarn --noconfirm

RUN useradd -m -G wheel user
#RUN useradd -m hardbox
USER user
RUN mkdir -p /home/user/tmp/
RUN wget -P /home/user/tmp/ https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
RUN ls /home/user/tmp/
#
RUN tar zxvf /home/user/tmp/yay.tar.gz -C /home/user/tmp/
#
RUN cd /home/user/tmp/yay
RUN cd /home/user/tmp/yay && makepkg -s
RUN cd /home/user/tmp/yay && sudo pacman --noconfirm -U *.xz
RUN sudo pacman -S --noconfirm influxdb grafana

RUN yay -Syua --noconfirm telegraf
#RUN yay -Syua --noconfirm chronograf
#RUN yay -Syua --noconfirm kapacitor
