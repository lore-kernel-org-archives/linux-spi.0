From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 0/5] Add Allwinner A31 SPI controller support
Date: Wed,  5 Feb 2014 14:05:02 +0100
Message-ID: <1391605507-30981-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBNHQZCLQKGQEFSFP2SY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

Hi everyone,

This patchset brings support for the SPI controller found in the
Allwinner A31 SoC.

Even though the controller supports DMA, the driver only supports PIO
mode for now. This driver will be used to bring up and test DMA on the
SoC, so support for the DMA will come eventually.

It doesn't support transfer larger than the FIFO size (128 bytes) for
now, I expect it to be fixed in the future.

Thanks!
Maxime

Changes from v3:
  - Rebased on top of 3.14-rc1
  - Removed the dependency on devm_spi_alloc_master
  - Modified the pm_runtime code according to reviews

Changes from v2:
  - Removed the select on runtime_pm
  - Fixed the clock error messages
  - Trigger the CS manually, and honour the enable bit in set_cs
  - Convert to devm_* functions
  - Remove useless clk_disable_unprepare in probe

Changes from v1:
  - Switched to using the transfer_one and set_cs callbacks
  - Switched to using runtime_pm
  - Report an error when we try to do a transfer larger than the FIFO
    size, instead of silently timeouting.
  - Added a Kconfig symbol
  - Move the clock ratio change at transfer time
  - Fixed the PLL6 cell size in the DTSI
  - A few fixes here and there: typos, etc.

Maxime Ripard (5):
  clk: sunxi: Add support for PLL6 on the A31
  ARM: sun6i: dt: Add PLL6 and SPI module clocks
  spi: sunxi: Add Allwinner A31 SPI controller driver
  ARM: sun6i: dt: Add SPI controllers to the A31 DTSI
  ARM: sunxi: Enable A31 SPI and SID in the defconfig

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../devicetree/bindings/spi/spi-sun6i.txt          |  24 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  86 +++-
 arch/arm/configs/sunxi_defconfig                   |   3 +
 drivers/clk/sunxi/clk-sunxi.c                      |  45 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sun6i.c                            | 483 +++++++++++++++++++++
 8 files changed, 640 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
 create mode 100644 drivers/spi/spi-sun6i.c

-- 
1.8.4.2
