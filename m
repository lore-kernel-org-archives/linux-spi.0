From: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/2] spi: spi-fsl-dspi: replace regmap R/W with internal implementation
Date: Wed, 27 Apr 2016 16:12:34 +0800
Message-ID: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <leoyang.li-3arQi8VN3Tc@public.gmane.org>, <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>

The qSPI controller's endian is independent of the CPU core's endian.

For eg, Core on NXP LS1043A SoC is little endian but DSPI is big endian
whereas Core on LS2080A SoC is little endian and DSPI also is little
endian on the same core.

At first we use regmap to cover this issue.
But the regmap is designed too large and complex.
The issue for regmap often effect the DSPI's stability.

DSPI driver just only need a effective way to R/W the controller register
with BE or LE mode.

So it's better to packaging a sample function.
This will make the DSPI driver more stability and high effective.

Yuan Yao (2):
  spi: spi-fsl-dspi: replace regmap R/W with internal implementation
  spi: spi-fsl-dspi: Update DT binding documentation

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   3 +-
 drivers/spi/spi-fsl-dspi.c                         | 101 +++++++++++++--------
 2 files changed, 62 insertions(+), 42 deletions(-)

-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
