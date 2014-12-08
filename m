From: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] ARM: sun4i: SPI improvements
Date: Mon,  8 Dec 2014 04:13:59 -0600
Message-ID: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a series of patches that gets SPI working in a better state on the
Cubieboard. The main motivation was to use flashrom to to program SPI ROMs.
There is one patch missing, which adds an spidev node on the Cubieboard. Since
Maxime did not like the approach in that patch, I've left it out for now.

Alexandru Gagniuc (3):
  ARM: sun4i: spi: Allow transfers larger than FIFO size
  ARM: sun4i: dt: Add pin muxing options for SPI
  ARM: sun4i: dt: cubieboard: Enable SPI0

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++
 arch/arm/boot/dts/sun4i-a10.dtsi           | 28 ++++++++++++
 drivers/spi/spi-sun4i.c                    | 71 ++++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 9 deletions(-)

-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
