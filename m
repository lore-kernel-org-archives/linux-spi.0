From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH/RFC] spi: core: Fix logic mismatch in spi_master.set_cs()
Date: Tue, 14 Jan 2014 12:36:51 +0100
Message-ID: <1389699411-29135-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

The documentation for spi_master.set_cs() says:

    assert or deassert chip select, true to assert

i.e. its "enable" parameter uses assertion-level logic.

This does not match the implementation of spi_set_cs(), which calls
spi_master.set_cs() with the wanted logical value of the chip select line,
i.e. "false" to assert an active low chip select, and "true" to assert an
active high chip select.

Correct the implementation to use assertion-level logic.

For GPIO-based chip selects, active high chip selects are still handled in
spi_set_cs(), as this is a direct GPIO level.
For SPI controller-based chip selects, active high chip selects must be
handled by the SPI master driver, if supported (some SPI controllers have
configurable chip select polarity).

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a86569e1f178..eb20169e84e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -561,13 +561,12 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
-	if (spi->mode & SPI_CS_HIGH)
-		enable = !enable;
-
-	if (spi->cs_gpio >= 0)
+	if (spi->cs_gpio >= 0) {
+		if (spi->mode & SPI_CS_HIGH)
+			enable = !enable;
 		gpio_set_value(spi->cs_gpio, !enable);
-	else if (spi->master->set_cs)
-		spi->master->set_cs(spi, !enable);
+	} else if (spi->master->set_cs)
+		spi->master->set_cs(spi, enable);
 }
 
 /*
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
