From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Sat, 15 Feb 2020 14:58:24 +0800
Message-ID: <20200215065826.739102-1-gch981213@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset adds a spi-mem driver for Mediatek SPI-NOR controller,
which already has limited support by mtk-quadspi. For benefits of
this replacement, please check commit message of the 1st patch.

To keep patchset small for easier reviewing, there will be 3 patchsets
including this one.
1. add the new driver, which is this patchset.
2. update existing dts for the new driver:
   spi-max-frequency is missing in current mtk-quadspi binding. Old
   driver parses child node manually so it doesn't need this, but
   new spi-mem driver is probed via spi subsystem which requires the
   presence of spi-max-frequency. Since this doesn't break old driver
   support, I'll send this separately as a standalone patch.
3. removing the old driver. I'll create this commit after 1 and 2 are
   applied to avoid possible rebasing due to any changes in the old
   driver.

Chuanhong Guo (2):
  spi: add support for mediatek spi-nor controller
  dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  34 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mtk-nor.c                     | 689 ++++++++++++++++++
 4 files changed, 715 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)
 create mode 100644 drivers/spi/spi-mtk-nor.c

-- 
2.24.1
