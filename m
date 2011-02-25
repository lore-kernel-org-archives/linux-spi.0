From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] OMAP: McSPI: catch xfers of non-multiple SPI word size
Date: Fri, 25 Feb 2011 16:55:11 +0100
Message-ID: <1298649311-9201-1-git-send-email-michael.jones@matrix-vision.de>
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If an SPI access was not a multiple of the SPI word size,
the while() loop would spin and the rx/tx ptrs would be incremented
indefinitely.

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 drivers/spi/omap2_mcspi.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index abb1ffb..9e439be 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -487,6 +487,9 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	rx_reg		= base + OMAP2_MCSPI_RX0;
 	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
 
+	if (c < (word_len>>3))
+		return 0;
+
 	if (word_len <= 8) {
 		u8		*rx;
 		const u8	*tx;
@@ -534,7 +537,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %02x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c);
+		} while (c > (word_len>>3));
 	} else if (word_len <= 16) {
 		u16		*rx;
 		const u16	*tx;
@@ -581,7 +584,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c);
+		} while (c > (word_len>>3));
 	} else if (word_len <= 32) {
 		u32		*rx;
 		const u32	*tx;
@@ -628,7 +631,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c);
+		} while (c > (word_len>>3));
 	}
 
 	/* for TX_ONLY mode, be sure all words have shifted out */
-- 
1.7.4.1


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
