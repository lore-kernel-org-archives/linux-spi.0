From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] spi bug fixes for v3.4
Date: Fri, 27 Apr 2012 12:36:56 -0600
Message-ID: <CACxGe6vsz_G4UN1O6JyBxWBymqxeYH3nxn7=vyASEE4D2dAf_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Florian Fainelli <florian@openwrt.org>,
	H Hartley Sweeten <hartleys@visionengravers.com>,
	Randy Dunlap <randy.dunlap@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 tags/spi-for-linus

for you to fetch changes up to 2431a8154634027ce3915200699f26fb3725a1f2:

  spi/spi-bfin5xx: Fix flush of last bit after each spi transfer
(2012-04-27 12:20:39 -0600)

----------------------------------------------------------------
Miscellaneous SPI device driver bug fixes for v3.4

----------------------------------------------------------------
Florian Fainelli (3):
      spi/bcm63xx: convert to the pump message infrastructure
      spi/bcm63xx: don't use the stopping state
      spi/bcm63xx: set master driver mode_bits.

H Hartley Sweeten (1):
      spi/spi-ep93xx.c: use dma_transfer_direction instead of dma_data_direction

Randy Dunlap (1):
      spi: fix spi.h kernel-doc warning

Scott Jiang (6):
      spi/bfin5xx: rename config macro name for bfin5xx spi controller driver
      spi/spi-bfin-sport: move word length setup to transfer handler
      spi/bfin_spi: drop bits_per_word from client data
      spi/spi_bfin_sport: drop bits_per_word from client data
      spi/spi-bfin5xx: fix reversed if condition in interrupt mode
      spi/spi-bfin5xx: Fix flush of last bit after each spi transfer

Vinit Shenoy (1):
      spi/pl022: Fix range checking for bits per word

Viresh Kumar (2):
      spi/pl022: Fix calculate_effective_freq()
      spi/pl022: Allow request for higher frequency than maximum possible

 drivers/spi/Kconfig          |    2 +-
 drivers/spi/Makefile         |    2 +-
 drivers/spi/spi-bcm63xx.c    |  163 ++++++++++++++++++++++++------------------
 drivers/spi/spi-bfin-sport.c |   21 +++---
 drivers/spi/spi-bfin5xx.c    |   14 ++--
 drivers/spi/spi-ep93xx.c     |   24 +++----
 drivers/spi/spi-pl022.c      |   58 ++++++++-------
 include/linux/spi/spi.h      |    2 +-
 8 files changed, 158 insertions(+), 128 deletions(-)
