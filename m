From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 6/8] spi: rspi: Add support for missing SPCR2 register
Date: Tue, 24 Dec 2013 12:40:46 +0100
Message-ID: <1387885248-28425-7-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for RSPI variants lacking the RSPI Control Register 2, based on
the SDK reference code. This is needed for RZ/A1H.

The availability of this register is passed using platform data, defaulting
to true for legacy RSPI. QSPI never has this register.

If the register is not available, it should not be touched.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c   |   17 ++++++++++++-----
 include/linux/spi/rspi.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 92aaa1eac5a9..34674fe6df5d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -192,6 +192,7 @@ struct rspi_data {
 	unsigned dma_width_16bit:1;
 	unsigned dma_callbacked:1;
 	unsigned txmode:1;
+	unsigned spcr2:1;
 };
 
 static void rspi_write8(const struct rspi_data *rspi, u8 data, u16 offset)
@@ -290,10 +291,14 @@ static int rspi_parse_platform_data(struct rspi_data *rspi,
 		rspi->spdcr = 0;
 	}
 
-	if (rspi_pd)
+	if (rspi_pd) {
 		rspi->txmode = rspi_pd->txmode;
-	else
-		rspi->txmode = 1;	/* legacy RSPI defaults to true */
+		rspi->spcr2 = rspi_pd->spcr2;
+	} else {
+		/* legacy RSPI defaults to true */
+		rspi->txmode = 1;
+		rspi->spcr2 = 1;
+	}
 
 	return 0;
 }
@@ -319,7 +324,8 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, 0x00, RSPI_SPND);
 
 	/* Sets parity, interrupt mask */
-	rspi_write8(rspi, 0x00, RSPI_SPCR2);
+	if (rspi->spcr2)
+		rspi_write8(rspi, 0x00, RSPI_SPCR2);
 
 	/* Sets SPCMD */
 	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | SPCMD_SSLKP,
@@ -341,8 +347,9 @@ static int qspi_parse_platform_data(struct rspi_data *rspi,
 	rspi->data_width = 8;
 	rspi->spdcr = 0;
 
-	/* No TX only mode */
+	/* No TX only mode, no parity register */
 	rspi->txmode = 0;
+	rspi->spcr2 = 0;
 
 	return 0;
 }
diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
index 0f5f612f0092..08d217f25413 100644
--- a/include/linux/spi/rspi.h
+++ b/include/linux/spi/rspi.h
@@ -29,6 +29,7 @@ struct rspi_plat_data {
 
 	unsigned dma_width_16bit:1;	/* DMAC read/write width = 16-bit */
 	unsigned txmode:1;		/* TX only mode */
+	unsigned spcr2:1;		/* Set parity register */
 
 	u16 num_chipselect;
 };
-- 
1.7.9.5

