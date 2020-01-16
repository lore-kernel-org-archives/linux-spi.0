From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/3] arm64: dts: sun50i: H6: Enable SPI controller
Date: Thu, 16 Jan 2020 00:56:51 +0000
Message-ID: <20200116005654.27672-1-andre.przywara@arm.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Even though the SPI controller in the Allwinner H6 SoC is more advanced
than in the previous generations (it supports 3-wire and 4-wire mode),
the register set stays backwards-compatible. So we can use the existing
driver to use the "normal" SPI mode, for instance to access the SPI
flash soldered on the Pine H64 board.

These two patches allow this by adding the SPI controller nodes to the
DT. The compatible strings include an H6 specific name, so that any
future 4-wire enhancements for instance would be automatically usable
once the driver learns this new trick. For now we use the H3 fallback
name to bind the current driver.

This time I tested this actual branch  (on top of sunxi/dt-for-5.6),
on a Pine H64, both the internal SPI flash as well with SPI flash
connected to the other SPI controller available on the GPIO headers.

As the SPI0-CS0 pin clashes with the eMMC CMD pin, we keep this
node disabled by default, to avoid losing the eMMC if it probes last.
People (or U-Boot) can enable it if needed.

Cheers,
Andre.

Changelog v1 ... v2:
- comment on pinmux clash between eMMC and SPI
- disable Pine H64 SPI flash node by default
- add binding doc for the new compatible string

Andre Przywara (3):
  arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
  arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
  dt-bindings: spi: sunxi: Document new compatible strings

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      | 12 +++--
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 19 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 55 ++++++++++++++++++++++
 3 files changed, 83 insertions(+), 3 deletions(-)

-- 
2.14.5
