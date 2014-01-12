From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH V2 6/8] spi: rspi: Add support for missing SPCR2 register
Date: Sun, 12 Jan 2014 11:27:42 +0100
Message-ID: <1389522464-1569-7-git-send-email-geert@linux-m68k.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add support for RSPI variants lacking the RSPI Control Register 2, based on
the SDK reference code. This is needed for RZ/A1H.

The availability of this register is passed using platform data, defaulting
to true for legacy RSPI. QSPI never has this register.

If the register is not available, it should not be touched.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V2:
  - Add Acked-by

 drivers/spi/spi-rspi.c   |   17 ++++++++++++-----
 include/linux/spi/rspi.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e507c2d6c710..18c56d1feb8e 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -201,6 +201,7 @@ struct rspi_data {
 	unsigned dma_width_16bit:1;
 	unsigned dma_callbacked:1;
 	unsigned txmode:1;
+	unsigned spcr2:1;
 };
 
 static void rspi_write8(const struct rspi_data *rspi, u8 data, u16 offset)
@@ -298,10 +299,14 @@ static int rspi_parse_platform_data(struct rspi_data *rspi,
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
@@ -327,7 +332,8 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, 0x00, RSPI_SPND);
 
 	/* Sets parity, interrupt mask */
-	rspi_write8(rspi, 0x00, RSPI_SPCR2);
+	if (rspi->spcr2)
+		rspi_write8(rspi, 0x00, RSPI_SPCR2);
 
 	/* Sets SPCMD */
 	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | SPCMD_SSLKP,
@@ -349,8 +355,9 @@ static int qspi_parse_platform_data(struct rspi_data *rspi,
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

