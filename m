From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/3] Add Mediatek SPI bus driver
Date: Wed, 29 Jul 2015 19:04:31 +0800
Message-ID: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Change in v4:
1. fix Mark Brown review comment.

Change in v3:
1. support fifo mode function.
2. support any non-prime length transfer in dma mode.
3. use interrupt to handle scatterlist.
4. fix review comment.


Change in v2:
1. Remove spi bitbang framwork, use can_dma() and transfer_one().
2. Add PM functions.
3. Fix Mark Brown review comment.

Leilk Liu (3):
  dt-binding: spi: Mediatek: Document devicetree bindings for spi bus
  spi: mediatek: Add spi bus for Mediatek MT8173
  arm64: dts: Add spi bus dts

 .../devicetree/bindings/spi/spi-mt65xx.txt         |  38 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  23 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mt65xx.c                           | 732 +++++++++++++++++++++
 include/linux/platform_data/spi-mt65xx.h           |  22 +
 6 files changed, 825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 create mode 100644 drivers/spi/spi-mt65xx.c
 create mode 100644 include/linux/platform_data/spi-mt65xx.h

--
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
