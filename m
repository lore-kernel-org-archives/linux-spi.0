From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: [PATCH v4 0/2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu,  7 May 2015 18:36:52 -0500
Message-ID: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch allows for GPIOs specified in the devicetree to be used as SPI
chipselects on TI OMAP2 SoCs.

Tested on the AM3354.

v4: Breaks patch down into patch series.

v3: Switches driver to use transfer_one instead of transfer_one_message
allowing the spi core to handle toggling GPIO chip selects if specified.

v2: Considers the possible use of SPI_CS_HIGH during chip select activation.

Michael Welling (2):
  spi: omap2-mcspi: Switch driver to use transfer_one
  spi: omap2-mcspi: Add gpio_request and init CS

 drivers/spi/spi-omap2-mcspi.c |  251 +++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 134 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
