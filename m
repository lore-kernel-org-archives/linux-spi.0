From: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/6] SPI ThunderX driver
Date: Sat, 23 Jul 2016 12:42:49 +0200
Message-ID: <cover.1469174814.git.jglauber@cavium.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

This series adds support for SPI on Cavium's ThunderX (arm64). The SPI
hardware is the same as on MIPS Octeon, the only difference is that the
device appears as a PCI device. To avoid copy and paste of the Octeon
driver I've moved the common parts into a shared file.

Patches #1-5 prepare the Octeon driver for re-use.

Patch #6 adds the ThunderX driver.

The series was tested on MIPS (Edge Router PRO and cn71xx) and ThunderX.

Feedback welcome!

thanks,
Jan

Jan Glauber (5):
  spi: octeon: Store system clock freqency in struct octeon_spi
  spi: octeon: Put register offsets into a struct
  spi: octeon: Move include file from arch/mips to drivers/spi
  spi: octeon: Split driver into Octeon specific and common parts
  spi: octeon: Add thunderx driver

Steven J. Hill (1):
  spi: octeon: Convert driver to use readq()/writeq() functions

 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   3 +
 drivers/spi/spi-cavium-octeon.c                    | 104 +++++++++
 drivers/spi/spi-cavium-thunderx.c                  | 158 +++++++++++++
 drivers/spi/spi-cavium.c                           | 151 ++++++++++++
 .../cvmx-mpi-defs.h => drivers/spi/spi-cavium.h    |  62 ++---
 drivers/spi/spi-octeon.c                           | 255 ---------------------
 7 files changed, 456 insertions(+), 284 deletions(-)
 create mode 100644 drivers/spi/spi-cavium-octeon.c
 create mode 100644 drivers/spi/spi-cavium-thunderx.c
 create mode 100644 drivers/spi/spi-cavium.c
 rename arch/mips/include/asm/octeon/cvmx-mpi-defs.h => drivers/spi/spi-cavium.h (84%)
 delete mode 100644 drivers/spi/spi-octeon.c

-- 
2.9.0.rc0.21.g7777322

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
