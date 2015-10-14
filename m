From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/5] mt8173 spi multiple devices support
Date: Wed, 14 Oct 2015 11:23:30 +0800
Message-ID: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series are based on 4.3-rc1 and provide 5 patches to support
mt8173 spi multiple devices.

Change in this series:
1. update document to add cs-gpio;
2. remove mtk_spi_config function;
3. move controller_data to master->setup;
4. add mt8173 spi multiple devices support;
5. update dts to add cs-gpio and modify cs pin to gpio function.

Leilk Liu (5):
  dt-binding: spi: Mediatek: Update document devicetree bindings to
    support multiple devices
  spi: mediatek: remove mtk_spi_config
  spi: mediatek: handle controller_data in mtk_spi_setup
  spi: mediatek: mt8173 spi multiple devices support
  arm64: dts: spi bus dts support multiple devices

 .../devicetree/bindings/spi/spi-mt65xx.txt         |   8 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   3 +-
 drivers/spi/spi-mt65xx.c                           | 129 +++++++++++++--------
 3 files changed, 91 insertions(+), 49 deletions(-)
 mode change 100755 => 100644 drivers/spi/spi-mt65xx.c

--
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
