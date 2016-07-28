From: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/2] SPI ThunderX driver
Date: Thu, 28 Jul 2016 10:31:42 +0200
Message-ID: <20160728083144.16625-1-jglauber@cavium.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series adds support for SPI on Cavium's ThunderX (arm64). The SPI
hardware is the same as on MIPS Octeon, the only difference is that the
device appears as a PCI device. To avoid copy and paste of the Octeon
driver I've moved the common parts into a shared file.

The series was tested on MIPS (Edge Router PRO and cn71xx) and ThunderX.

Changes to v1:
- Changed Kconfig depencency for ThunderX
- Merged clock setup functions with main probe/remove
- Fail if SPI DT entry misses clock reference
- Removed debug prints at end of probe
- Removed unneeded includes from spi-cavium.c
- Dropped merged patches

thanks,
Jan

--------------

Jan Glauber (2):
  spi: octeon: Split driver into Octeon specific and common parts
  spi: octeon: Add thunderx driver

 drivers/spi/Kconfig                        |   7 ++
 drivers/spi/Makefile                       |   3 +
 drivers/spi/spi-cavium-octeon.c            | 102 +++++++++++++++++++++
 drivers/spi/spi-cavium-thunderx.c          | 140 +++++++++++++++++++++++++++++
 drivers/spi/{spi-octeon.c => spi-cavium.c} | 122 +------------------------
 drivers/spi/spi-cavium.h                   |  34 +++++++
 6 files changed, 288 insertions(+), 120 deletions(-)
 create mode 100644 drivers/spi/spi-cavium-octeon.c
 create mode 100644 drivers/spi/spi-cavium-thunderx.c
 rename drivers/spi/{spi-octeon.c => spi-cavium.c} (54%)

-- 
2.9.0.rc0.21.g7777322

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
