From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/2] arm64: dts: sun50i: H6: Enable SPI flash
Date: Wed,  8 Jan 2020 10:10:04 +0000
Message-ID: <20200108101006.150706-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBFGV23YAKGQEVALBGYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Even though the SPI controller in the Allwinner H6 SoC is more advanced
than in the previous generations (it supports 3-wire and 4-wire mode),
the register set stayed backwards-compatible. So we can use the existing
driver to use the "normal" SPI mode, for instance to access the SPI
flash soldered on the Pine H64 board.

These two patches allow this by adding the SPI controller nodes to the
DT. The compatible strings include an H6 specific name, so that any
future 4-wire enhancements for instance would be automatically usable
once the driver learns this new trick. For now we use the H3 fallback
name to bind the current driver.

This time I tested this actual branch ;-) (on top of sunxi/dt-for-5.6),
on a Pine H64, both the internal SPI flash as well with SPI flash
connected to the other SPI controller available on the GPIO headers.

One thing I noticed: Only SPI0 seems to connect the two extra pins
required for 4-wire mode. Does this require some extra DT property or
the like? Can we derive this from the number of pins in the pinctrl-0
property? Or will we later introduce a new compatible string to prepend
to the current list?

Cheers,
Andre.

Andre Przywara (2):
  arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
  arm64: dts: allwinner: h6: Pine H64: Add SPI flash node

 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 13 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 54 +++++++++++++++++++
 2 files changed, 67 insertions(+)

-- 
2.17.1
