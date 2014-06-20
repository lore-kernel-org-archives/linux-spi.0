From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 0/2] spi: sh-msiof: Add DT DMA support on r8a7791
Date: Fri, 20 Jun 2014 12:20:36 +0200
Message-ID: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This preliminary patch series add DT support to the Renesas MSIOF SPI
driver, and enables DMA support for MSIOF on r8a7791.

It's independent from the series "[PATCH/POC 0/2] ARM: shmobile: koelsch
legacy: Enable DMA for MSIOF", but it depends on the SHDMA work for r8a7790
by Ben Dooks (still v2, cfr. "[PATCH v2 0/9] Updates Renesas OF-DMA code"),
and my series "[PATCH v2 0/7] ARM: shmobile: koelsch reference: Enable DMA
for QSPI".

This was tested on r8a7791/koelsch.

  [1/2] spi: sh-msiof: Add DT support to DMA setup
  [2/2] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 17 +++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi                     | 15 ++++++++++---
 drivers/spi/spi-sh-msiof.c                         | 25 ++++++++++++++++------
 3 files changed, 45 insertions(+), 12 deletions(-)

As the DT bindings for SHDMA are still under development, I don't expect
this to be applied yet.

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
