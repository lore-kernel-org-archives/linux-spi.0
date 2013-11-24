From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Subject: [PATCH] Fix long standing chip select issue for non-default CS-polarity setups
Date: Sun, 24 Nov 2013 19:08:32 +0100
Message-ID: <A4EEA261-22E6-41A7-82C4-68E8606E0863@martin.sperl.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org,
	swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixes long standing chip select issue for non-default CS-polarity setups.

The issue only shows up if 2 devices are on the bus and at least one of them
is configured for inverse chip_select polarity.

Essentially the polarity bits in the SPI controller registers are getting
reset to 0 (=default polarity) whenever a different SPI device is activated.

This only negatively impacts SPI devices on the bus with non-default polarity.

This patch makes use of spi_master->setup to set up the flags for all possible
variants of the chip-select polarity flags during device setup.

It also moves repeated calculations from bcm2835_spi_start_transfer into setup.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 4c33214..95ee83f 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -73,6 +73,8 @@
 #define BCM2835_SPI_TIMEOUT_MS	30000
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS)
 
+#define BCM2835_SPI_NUM_CS	3
+
 #define DRV_NAME	"spi-bcm2835"
 
 struct bcm2835_spi {
@@ -83,6 +85,8 @@ struct bcm2835_spi {
 	const u8 *tx_buf;
 	u8 *rx_buf;
 	int len;
+	u32 cs_device_flags_idle;
+	u32 cs_device_flags[BCM2835_SPI_NUM_CS];
 };
 
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
@@ -203,19 +207,8 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 	} else
 		cdiv = 0; /* 0 is the slowest we can go */
 
-	if (spi->mode & SPI_CPOL)
-		cs |= BCM2835_SPI_CS_CPOL;
-	if (spi->mode & SPI_CPHA)
-		cs |= BCM2835_SPI_CS_CPHA;
-
-	if (!(spi->mode & SPI_NO_CS)) {
-		if (spi->mode & SPI_CS_HIGH) {
-			cs |= BCM2835_SPI_CS_CSPOL;
-			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
-		}
-
-		cs |= spi->chip_select;
-	}
+	/* take cs from the precalculated version */
+	cs |= bs->cs_device_flags[spi->chip_select];
 
 	INIT_COMPLETION(bs->done);
 	bs->tx_buf = tfr->tx_buf;
@@ -291,13 +284,41 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 out:
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
-		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+		bs->cs_device_flags_idle
+		| BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 	mesg->status = err;
 	spi_finalize_current_message(master);
 
 	return 0;
 }
 
+static int bcm2835_spi_setup(struct spi_device *spi) {
+	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
+	u8 cs = spi->chip_select;
+	u32 mode = spi->mode;
+	int i;
+
+	if (!(mode & SPI_NO_CS)) {
+		if (mode & SPI_CS_HIGH) {
+			for (i=0 ; i<=BCM2835_SPI_NUM_CS ; i++) {
+				bs->cs_device_flags[i] |=
+					(BCM2835_SPI_CS_CSPOL0 << cs);
+			}
+			bs->cs_device_flags_idle |=
+				(BCM2835_SPI_CS_CSPOL0 << cs);
+			bs->cs_device_flags[cs] |= BCM2835_SPI_CS_CSPOL;
+		}
+		bs->cs_device_flags[cs] |= spi->chip_select;
+	}
+
+	if (mode & SPI_CPOL)
+		bs->cs_device_flags[cs] |= BCM2835_SPI_CS_CPOL;
+	if (mode & SPI_CPHA)
+		bs->cs_device_flags[cs] |= BCM2835_SPI_CS_CPHA;
+
+	return 0;
+}
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -316,7 +337,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->mode_bits = BCM2835_SPI_MODE_BITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->bus_num = -1;
-	master->num_chipselect = 3;
+	master->num_chipselect = BCM2835_SPI_NUM_CS;
+	master->setup = bcm2835_spi_setup;
 	master->transfer_one_message = bcm2835_spi_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
