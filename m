From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/4] SPI: support mt2701 IC
Date: Thu, 31 Dec 2015 10:58:59 +0800
Message-ID: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
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

This series are based on 4.4-rc1 and provide 4 patches to support
mt2701 spi HW.

Change in this series:
1. merge all identical compat to mtk_common_compat;
2. Add spi support for mt2701 IC;
3. add spi dts for mt2701;
4. Add bindings for mediatek MT2701 soc platform.

Leilk Liu (4):
  spi: mediatek: merge all identical compat to mtk_common_compat
  spi: mediatek: Add spi support for mt2701 IC
  dts: mt2701: add spi dts for mt2701
  Document: spi: Add bindings for mediatek MT2701 soc platform

 .../devicetree/bindings/spi/spi-mt65xx.txt         |    5 ++-
 arch/arm/boot/dts/mt2701.dtsi                      |   39 ++++++++++++++++++++
 drivers/spi/spi-mt65xx.c                           |   18 ++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

--
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
