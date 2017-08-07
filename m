From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: use of_property_read_bool()" to the spi tree
Date: Mon, 07 Aug 2017 12:52:18 +0100
Message-ID: <E1dega2-0006v5-LX@debutante>
References: <20170806201546.905810410@cogentembedded.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170806201546.905810410-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: use of_property_read_bool()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e0bcb680b152c96ee4b561abbeb18743cdcc5ae3 Mon Sep 17 00:00:00 2001
From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Date: Sun, 6 Aug 2017 23:15:31 +0300
Subject: [PATCH] spi: use of_property_read_bool()

Use a bit more compact of_property_read_bool() calls instead of the
of_find_property() calls -- symmetrically with the of_property_read_u32()
calls already done in of_spi_parse_dt().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fe7bba9241ea..aed78093b130 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1532,15 +1532,15 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	int rc;
 
 	/* Mode (clock phase/polarity/etc.) */
-	if (of_find_property(nc, "spi-cpha", NULL))
+	if (of_property_read_bool(nc, "spi-cpha"))
 		spi->mode |= SPI_CPHA;
-	if (of_find_property(nc, "spi-cpol", NULL))
+	if (of_property_read_bool(nc, "spi-cpol"))
 		spi->mode |= SPI_CPOL;
-	if (of_find_property(nc, "spi-cs-high", NULL))
+	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
-	if (of_find_property(nc, "spi-3wire", NULL))
+	if (of_property_read_bool(nc, "spi-3wire"))
 		spi->mode |= SPI_3WIRE;
-	if (of_find_property(nc, "spi-lsb-first", NULL))
+	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |= SPI_LSB_FIRST;
 
 	/* Device DUAL/QUAD mode */
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
