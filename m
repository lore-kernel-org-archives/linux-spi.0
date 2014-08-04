From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: [PATCH v3 0/8] DMAEngine support for sun4i, sun5i & sun7i
Date: Mon,  4 Aug 2014 17:09:54 -0300
Message-ID: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi everyone,

As part of Google Summer of Code, I've tasked myself with implementing
DMA support for the earlier Allwinner platforms. This third round of
patches is the result of said effort.

The first patch is the actual driver to support these platforms. Patche=
s
three, four and five add the corresponding DMA node to the sun4i, sun5i
and sun7i device trees.

The second patch, involving the sunxi SPI driver, lets users do SPI
transfers of >=3D64 bytes by using DMA. Patches six, seven and eight ad=
d
the DMA properties to SPI so the first two patches can be used.

All comments and reviews are welcome :)

Thanks!

Emilio

Emilio L=C3=B3pez (8):
  dma: sun4i: Add support for the DMA engine on sun[457]i SoCs
  spi: sun4i: add DMA support
  ARM: sun4i: dt: Add node to represent the DMA controller
  ARM: sun5i: dt: Add nodes to represent the DMA controllers
  ARM: sun7i: dt: Add node to represent the DMA controller
  ARM: sun4i: dt: enable DMA on SPI
  ARM: sun5i: dt: enable DMA on SPI
  ARM: sun7i: dt: enable DMA on SPI

 .../devicetree/bindings/dma/sun4i-dma.txt          |   46 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   16 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   14 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   14 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   16 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1238 ++++++++++++=
++++++++
 drivers/spi/spi-sun4i.c                            |  155 ++-
 9 files changed, 1500 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

--=20
2.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
