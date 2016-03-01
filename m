From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: [PATCH 4/6] spi: davinci: set new SPI_FC_* flags
Date: Tue,  1 Mar 2016 15:43:18 +0100
Message-ID: <1456843400-20696-4-git-send-email-linux@rempel-privat.de>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456843400-20696-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

to indicate flow control support.

Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index fddb7a3..8728df9 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -351,8 +351,8 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	 *
 	 * Version 2 hardware supports an optional handshaking signal,
 	 * so it can support two more modes:
-	 *  - 5 pin SPI variant is standard SPI plus SPI_READY
-	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
+	 *  - 5 pin SPI variant is standard SPI plus SPI_FC_READY
+	 *  - 4 pin with enable is (SPI_FC_READY | SPI_NO_CS)
 	 */
 
 	if (dspi->version == SPI_VERSION_2) {
@@ -374,7 +374,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 						& SPIDELAY_T2CDELAY_MASK;
 		}
 
-		if (spi->mode & SPI_READY) {
+		if (spi->mode & SPI_FC_READY) {
 			spifmt |= SPIFMT_WAITENA_MASK;
 			delay |= (spicfg->t2edelay << SPIDELAY_T2EDELAY_SHIFT)
 						& SPIDELAY_T2EDELAY_MASK;
@@ -452,7 +452,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
 	}
 
-	if (spi->mode & SPI_READY)
+	if (spi->mode & SPI_FC_READY)
 		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
 
 	if (spi->mode & SPI_LOOP)
@@ -1021,7 +1021,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
 	if (dspi->version == SPI_VERSION_2)
-		dspi->bitbang.flags |= SPI_READY;
+		dspi->bitbang.flags |= SPI_FC_HW_ONLY | SPI_FC_READY | SPI_FC_PAUSE;
 
 	if (pdev->dev.of_node) {
 		int i;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
