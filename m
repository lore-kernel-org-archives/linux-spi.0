From: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/3] spicc: meson-axg: add SPICC controller
Date: Tue, 28 Nov 2017 21:29:23 +0800
Message-ID: <20171128132926.19051-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
        Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add the SPICC controller driver to the Amlogic's Meson-AXG SoC.
The new compatible string introduced here is aiming for adding
a few new features which found at the Meson-AXG platform.

Sunny Luo (3):
  dt-bindings: spicc: update compatible string for the Meson-AXG
  spi: meson-axg: add SPICC driver support
  ARM64: dts: meson-axg: add the SPICC controller

 .../devicetree/bindings/spi/spi-meson.txt          |  4 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 92 ++++++++++++++++++++++
 drivers/spi/spi-meson-spicc.c                      |  1 +
 3 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
