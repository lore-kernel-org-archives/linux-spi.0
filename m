From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] 2nd batch of SPI changes
Date: Thu, 17 Dec 2009 08:40:57 -0800
Message-ID: <fa686aa40912170840h6bd921b4me244cb83c31cab7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764683AbZLQQlX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

This is later than I'd like it to be, and I hope it gets to you before
you cut -rc1.  There was some slack between Andrew and I on handing
off SPI maintainership.  Patches I had picked up in the last batch
conflicted with his stack and we decided it was best if I just take
the remainder of his SPI queue and commit them to my tree.
(Basically, I made the mess, so I got to clean it up).  It took me a
bit to get sorted out.

Commits in this batch are either a) from Andrew's tree, b) trivial
fixes from the list, or c) new drivers.

The following changes since commit 718deb6b61e34c200c1f2b706176d9aac334cb2d:
  Al Viro (1):
        Fix breakage in shmem.c

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-spi

Ben Dooks (1):
      spi_s3c24xx: add FIQ pseudo-DMA support

Ben Nizette (1):
      atmel_spi: fix dma addr calculation for len > BUFFER_SIZE

Feng Tang (1):
      spi: controller driver for Designware SPI core

Jassi Brar (1):
      spi: Add s3c64xx SPI Controller driver

Mike Frysinger (1):
      spidev: add proper section markers

Thadeu Lima de Souza Cascardo (1):
      spidev: use DECLARE_BITMAP instead of declaring the array

hartleys (5):
      spi: atmel_spi.c: use resource_size()
      spi: spi_bfin5xx.c: use resource_size()
      spi: spi_mpc8xxx.c: use resource_size()
      spi: spi_sh_sci.c: use resource_size()
      spi: spi_txx9.c: use resource_size()

 arch/arm/mach-s3c2410/include/mach/spi.h |    2 +
 drivers/spi/Kconfig                      |   28 +
 drivers/spi/Makefile                     |   10 +-
 drivers/spi/atmel_spi.c                  |    6 +-
 drivers/spi/dw_spi.c                     |  944 +++++++++++++++++++++++
 drivers/spi/dw_spi_pci.c                 |  169 +++++
 drivers/spi/spi_bfin5xx.c                |    2 +-
 drivers/spi/spi_mpc8xxx.c                |    2 +-
 drivers/spi/spi_s3c24xx.c                |  244 ++++++-
 drivers/spi/spi_s3c24xx_fiq.S            |  116 +++
 drivers/spi/spi_s3c24xx_fiq.h            |   26 +
 drivers/spi/spi_s3c64xx.c                | 1196 ++++++++++++++++++++++++++++++
 drivers/spi/spi_sh_sci.c                 |    2 +-
 drivers/spi/spi_txx9.c                   |    6 +-
 drivers/spi/spidev.c                     |   18 +-
 include/linux/spi/dw_spi.h               |  212 ++++++
 16 files changed, 2950 insertions(+), 33 deletions(-)
 create mode 100644 drivers/spi/dw_spi.c
 create mode 100644 drivers/spi/dw_spi_pci.c
 create mode 100644 drivers/spi/spi_s3c24xx_fiq.S
 create mode 100644 drivers/spi/spi_s3c24xx_fiq.h
 create mode 100644 drivers/spi/spi_s3c64xx.c
 create mode 100644 include/linux/spi/dw_spi.h


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
