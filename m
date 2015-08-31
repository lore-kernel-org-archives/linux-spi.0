From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/3] Fix Mediatek SPI bus driver clock usage error
Date: Mon, 31 Aug 2015 21:18:55 +0800
Message-ID: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
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

From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This series are based on 4.2-rc1 and provide three patches
to fix mediatek spi driver clock usage error.

spi clock manages flow:
  CLK_TOP_SYSPLL3_D2 ---> CLK_TOP_SPI_SEL ---> CLK_PERI_SPI0
    (source clock)           (clock mux)       (clock gate)
spi driver should choose source clock by clock mux, then enable clock gate.

Leilk Liu (3):
  spi: mediatek: remove clk_disable_unprepare()
  spi: mediatek: fix spi clock usage error
  spi: Mediatek: Document devicetree bindings update for spi bus

 .../devicetree/bindings/spi/spi-mt65xx.txt         | 16 +++++++++------
 drivers/spi/spi-mt65xx.c                           | 24 ++++++++++++++--------
 2 files changed, 25 insertions(+), 15 deletions(-)

--
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
