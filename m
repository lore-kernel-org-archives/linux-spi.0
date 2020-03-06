From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/4] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Fri,  6 Mar 2020 16:50:48 +0800
Message-ID: <20200306085052.28258-1-gch981213@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patchset adds a spi-mem driver for Mediatek SPI-NOR controller,
which already has limited support by mtk-quadspi. This new driver can
make use of full quadspi capability of this controller.

1st new commit makes spi-max-frequency optional to match current
binding doc and make this new driver compatible with old driver dt
bindings.

Change since v2:
 revert binding example replacement and add a dummy irq binding

Changes since v1:
 two new commits.

Chuanhong Guo (4):
  spi: make spi-max-frequency optional
  spi: add support for mediatek spi-nor controller
  dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
  mtd: spi-nor: remove mtk-quadspi driver

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  15 +-
 drivers/mtd/spi-nor/Kconfig                   |   8 -
 drivers/mtd/spi-nor/Makefile                  |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c             | 565 --------------
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mtk-nor.c                     | 689 ++++++++++++++++++
 drivers/spi/spi.c                             |   9 +-
 8 files changed, 708 insertions(+), 590 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c

-- 
2.24.1
