From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] spi: cadence: Make sure that clock polarity changes are applied
Date: Thu, 10 Jul 2014 11:26:28 +0200
Message-ID: <1404984389-12802-1-git-send-email-lars@metafoo.de>
Cc: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It seems that the cadence SPI controller does not immediately change the clock
polarity setting when writing the CR register. Instead the change is delayed
until the next transfer starts. This happens after the chip select line has
already been asserted. As a result the first transfer after a clock polarity
change will generate spurious clock transitions which typically results in the
SPI slave not being able to properly understand the message. Toggling the ER
register seems to cause the SPI controller to apply the clock polarity changes,
so implement this as a workaround to fix the issue.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 98b763b..03f4d5e 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -205,18 +205,30 @@ static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 static void cdns_spi_config_clock_mode(struct spi_device *spi)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
-	u32 ctrl_reg;
+	u32 ctrl_reg, new_ctrl_reg;
 
-	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR_OFFSET);
+	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR_OFFSET);
 
 	/* Set the SPI clock phase and clock polarity */
-	ctrl_reg &= ~(CDNS_SPI_CR_CPHA_MASK | CDNS_SPI_CR_CPOL_MASK);
+	new_ctrl_reg &= ~(CDNS_SPI_CR_CPHA_MASK | CDNS_SPI_CR_CPOL_MASK);
 	if (spi->mode & SPI_CPHA)
-		ctrl_reg |= CDNS_SPI_CR_CPHA_MASK;
+		new_ctrl_reg |= CDNS_SPI_CR_CPHA_MASK;
 	if (spi->mode & SPI_CPOL)
-		ctrl_reg |= CDNS_SPI_CR_CPOL_MASK;
-
-	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, ctrl_reg);
+		new_ctrl_reg |= CDNS_SPI_CR_CPOL_MASK;
+
+	if (new_ctrl_reg != ctrl_reg) {
+		/*
+		 * Just writing the CR register does not seem to apply the clock
+		 * setting changes. This is problematic when changing the clock
+		 * polarity as it will cause the SPI slave to see spurious clock
+		 * transitions. To workaround the issue toggle the ER register.
+		 */
+		cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
+				   CDNS_SPI_ER_DISABLE_MASK);
+		cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, new_ctrl_reg);
+		cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
+				   CDNS_SPI_ER_ENABLE_MASK);
+	}
 }
 
 /**
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
