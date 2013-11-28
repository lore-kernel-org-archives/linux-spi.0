From: Thomas Behan <thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: omap-100k: Fixed spacing on while loops
Date: Wed, 27 Nov 2013 23:27:21 -0500
Message-ID: <1385612844-22482-2-git-send-email-thomas.behan@gmail.com>
References: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Cc: broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Behan <thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385612844-22482-1-git-send-email-thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

checkpatch.pl generated several errors from "while(" statements which should
have read "while (" to comply with the style guide. These errors have been
fixed.

Signed-off-by: Thomas Behan <thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b6ed82b..bdf6696 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -147,7 +147,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 	       spi100k->base + SPI_CTRL);
 
 	/* Wait for bit ack send change */
-	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) != SPI_STATUS_WE);
+	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) != SPI_STATUS_WE);
 	udelay(1000);
 
 	spi100k_disable_clock(master);
@@ -168,7 +168,7 @@ static int spi100k_read_data(struct spi_master *master, int len)
 	       SPI_CTRL_RD,
 	       spi100k->base + SPI_CTRL);
 
-	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) != SPI_STATUS_RD);
+	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) != SPI_STATUS_RD);
 	udelay(1000);
 
 	dataL = readw(spi100k->base + SPI_RX_LSB);
@@ -226,7 +226,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
 				*rx++ = spi100k_read_data(spi->master, word_len);
-		} while(c);
+		} while (c);
 	} else if (word_len <= 16) {
 		u16             *rx;
 		const u16       *tx;
@@ -239,7 +239,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				spi100k_write_data(spi->master,word_len, *tx++);
 			if (xfer->rx_buf != NULL)
 				*rx++ = spi100k_read_data(spi->master,word_len);
-		} while(c);
+		} while (c);
 	} else if (word_len <= 32) {
 		u32             *rx;
 		const u32       *tx;
@@ -252,7 +252,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				spi100k_write_data(spi->master,word_len, *tx);
 			if (xfer->rx_buf != NULL)
 				*rx = spi100k_read_data(spi->master,word_len);
-		} while(c);
+		} while (c);
 	}
 	return count - c;
 }
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
