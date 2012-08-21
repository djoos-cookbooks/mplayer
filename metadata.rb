maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures mplayer"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.5"

supports "ubuntu"
supports "debian"

depends "build-essential"
depends "yasm"
depends "subversion"
depends "git"