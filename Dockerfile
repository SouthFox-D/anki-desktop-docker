FROM lsiobase/kasmvnc:arch

RUN \
  pacman -Syyu --noconfirm && \
  pacman -S wget fakeroot --noconfirm && \
  useradd non_root && \
  echo "non_root ALL=NOPASSWD: ALL" >> /etc/sudoers && \
  sudo -u non_root mkdir /tmp/anki_build && \
  sudo -u non_root wget "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=anki-bin" -O /tmp/anki_build/PKGBUILD && \
  sudo -u non_root makepkg -si -D /tmp/anki_build --noconfirm && \
  rm -rf /tmp/anki_build && \
  mkdir -p /config/.local/share && \
  ln -s /config/app/Anki  /config/.local/share/Anki  && \
  ln -s /config/app/Anki2 /config/.local/share/Anki2 && \
  ln -s /config/app/syncserver /config/.syncserver

VOLUME "/config/app" 

COPY ./root /
