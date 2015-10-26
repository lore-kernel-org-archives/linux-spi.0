From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/5] mt8173 spi multiple devices support
Date: Mon, 26 Oct 2015 16:09:40 +0800
Message-ID: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
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

Change in v2:
1. add mt8173 board name on patch 5/5 subject.
2. fix this series merge conflict.

Change in v1:
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
  arm64: dts: mt8173: spi bus dts support multiple devices

 .../devicetree/bindings/spi/spi-mt65xx.txt         |   9 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   3 +-
 drivers/spi/spi-mt65xx.c                           | 129 +++++++++++++--------
 3 files changed, 91 insertions(+), 50 deletions(-)

--
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
