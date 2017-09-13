From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] spi: Fix failing commands with quad pins on A3700
Date: Wed, 13 Sep 2017 09:48:02 +0200
Message-ID: <20170913074802.9366-1-miquel.raynal@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A3700 SPI controller datasheet states that only the first line (IO0) is
used to receive and send instructions, addresses and dummy bytes,
unless for addresses during an RX operation in a quad SPI configuration
(see p.821 of the Armada-3720-DB datasheet). Otherwise, some commands
such as SPI NOR commands like READ_FROM_CACHE_DUAL_IO(0xeb) and
READ_FROM_CACHE_DUAL_IO(0xbb) will fail because these commands must send
address bytes through the four pins. Data transfer always use the four
bytes with this setup.

Thus, in quad SPI configuration, the A3700_SPI_ADDR_PIN bit must be set
only in this case to inform the controller that it must use the number
of pins indicated in the {A3700_SPI_DATA_PIN1,A3700_SPI_DATA_PIN0} field
during the address cycles of an RX operation.

Suggested-by: Ken Ma <make-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-armada-3700.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 6c7d7a460689..a28702b1fa05 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -161,7 +161,7 @@ static void a3700_spi_deactivate_cs(struct a3700_spi *a3700_spi,
 }
 
 static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
-				  unsigned int pin_mode)
+				  unsigned int pin_mode, bool receiving)
 {
 	u32 val;
 
@@ -177,6 +177,9 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 		break;
 	case SPI_NBITS_QUAD:
 		val |= A3700_SPI_DATA_PIN1;
+		/* RX during address reception uses 4-pin */
+		if (receiving)
+			val |= A3700_SPI_ADDR_PIN;
 		break;
 	default:
 		dev_err(&a3700_spi->master->dev, "wrong pin mode %u", pin_mode);
@@ -653,7 +656,7 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	else if (xfer->rx_buf)
 		nbits = xfer->rx_nbits;
 
-	a3700_spi_pin_mode_set(a3700_spi, nbits);
+	a3700_spi_pin_mode_set(a3700_spi, nbits, xfer->rx_buf ? true : false);
 
 	if (xfer->rx_buf) {
 		/* Set read data length */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
