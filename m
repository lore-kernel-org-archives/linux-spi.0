From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/7] Add Allwinner A10 SPI Controller Driver
Date: Sat, 22 Feb 2014 22:35:52 +0100
Message-ID: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBNVSUSMAKGQEA5ZUOMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

Hi,

This patchset brings support for the SPI controller found in the
Allwinner A10 and derived SoCs.

Even though the controller supports DMA, the driver only supports PIO
mode for now. This driver will be used to bring up and test DMA on the
SoC, so support for the DMA will come eventually.

It doesn't support transfer larger than the FIFO size (64 bytes) for
now, It's one of the things that will be fixed whenever we will have
DMA support.

Thanks!
Maxime

Maxime Ripard (7):
  spi: sunxi: Add Allwinner A10 SPI controller driver
  ARM: dt: sun7i: Add A20 SPI controller nodes
  ARM: dt: sun4i: Add A10 SPI controller nodes
  ARM: dt: sun5i: Add A10s SPI controller nodes
  ARM: dt: sun5i: Add A13 SPI controller nodes
  ARM: dt: sun7i: Add SPI muxing options
  ARM: dts: sun7i: Enable the SPI controllers of the A20-olinuxino-micro

 .../devicetree/bindings/spi/spi-sun4i.txt          |  24 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  44 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  33 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  33 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  17 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  58 +++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sun4i.c                            | 477 +++++++++++++++++++++
 9 files changed, 693 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt
 create mode 100644 drivers/spi/spi-sun4i.c

-- 
1.9.0
