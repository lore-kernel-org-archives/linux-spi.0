From: Aaron Brice <aaron.brice@datasoft.com>
Subject: [PATCH v3 3/3] spi: fsl-dspi: Add ~50ns delay between cs and sck
Date: Fri,  3 Apr 2015 13:39:31 -0700
Message-ID: <1428093571-20407-4-git-send-email-aaron.brice@datasoft.com>
References: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefan@agner.ch, devicetree@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add delay between chip select and clock signals, before clock starts and
after clock stops.

Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
---
 drivers/spi/spi-fsl-dspi.c | 64 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8213358..5fe54cd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -29,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
+#include <linux/time.h>
 
 #define DRIVER_NAME "fsl-dspi"
 
@@ -51,7 +53,7 @@
 #define SPI_CTAR_CPOL(x)	((x) << 26)
 #define SPI_CTAR_CPHA(x)	((x) << 25)
 #define SPI_CTAR_LSBFE(x)	((x) << 24)
-#define SPI_CTAR_PCSSCR(x)	(((x) & 0x00000003) << 22)
+#define SPI_CTAR_PCSSCK(x)	(((x) & 0x00000003) << 22)
 #define SPI_CTAR_PASC(x)	(((x) & 0x00000003) << 20)
 #define SPI_CTAR_PDT(x)	(((x) & 0x00000003) << 18)
 #define SPI_CTAR_PBR(x)	(((x) & 0x00000003) << 16)
@@ -59,6 +61,7 @@
 #define SPI_CTAR_ASC(x)	(((x) & 0x0000000f) << 8)
 #define SPI_CTAR_DT(x)		(((x) & 0x0000000f) << 4)
 #define SPI_CTAR_BR(x)		((x) & 0x0000000f)
+#define SPI_CTAR_SCALE_BITS	0xf
 
 #define SPI_CTAR0_SLAVE	0x0c
 
@@ -176,6 +179,40 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 	}
 }
 
+static void ns_delay_scale(char *psc, char *sc, int delay_ns,
+		unsigned long clkrate)
+{
+	int pscale_tbl[4] = {1, 3, 5, 7};
+	int scale_needed, scale, minscale = INT_MAX;
+	int i, j;
+	u32 remainder;
+
+	scale_needed = div_u64_rem((u64)delay_ns * clkrate, NSEC_PER_SEC,
+			&remainder);
+	if (remainder)
+		scale_needed++;
+
+	for (i = 0; i < ARRAY_SIZE(pscale_tbl); i++)
+		for (j = 0; j <= SPI_CTAR_SCALE_BITS; j++) {
+			scale = pscale_tbl[i] * (2 << j);
+			if (scale >= scale_needed) {
+				if (scale < minscale) {
+					minscale = scale;
+					*psc = i;
+					*sc = j;
+				}
+				break;
+			}
+		}
+
+	if (minscale == INT_MAX) {
+		pr_warn("Cannot find correct scale values for %dns delay at clkrate %ld, using max prescaler value",
+			delay_ns, clkrate);
+		*psc = ARRAY_SIZE(pscale_tbl) - 1;
+		*sc = SPI_CTAR_SCALE_BITS;
+	}
+}
+
 static int dspi_transfer_write(struct fsl_dspi *dspi)
 {
 	int tx_count = 0;
@@ -354,7 +391,10 @@ static int dspi_setup(struct spi_device *spi)
 {
 	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
-	unsigned char br = 0, pbr = 0, fmsz = 0;
+	u32 cs_sck_delay = 0, sck_cs_delay = 0;
+	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	unsigned char pasc = 0, asc = 0, fmsz = 0;
+	unsigned long clkrate;
 
 	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
 		fmsz = spi->bits_per_word - 1;
@@ -371,18 +411,34 @@ static int dspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 	}
 
+	of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
+			&cs_sck_delay);
+
+	of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
+			&sck_cs_delay);
+
 	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
 		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
 
 	chip->void_write_data = 0;
 
-	hz_to_spi_baud(&pbr, &br,
-			spi->max_speed_hz, clk_get_rate(dspi->clk));
+	clkrate = clk_get_rate(dspi->clk);
+	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
+
+	/* Set PCS to SCK delay scale values */
+	ns_delay_scale(&pcssck, &cssck, cs_sck_delay, clkrate);
+
+	/* Set After SCK delay scale values */
+	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
 	chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
 		| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
 		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
 		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
+		| SPI_CTAR_PCSSCK(pcssck)
+		| SPI_CTAR_CSSCK(cssck)
+		| SPI_CTAR_PASC(pasc)
+		| SPI_CTAR_ASC(asc)
 		| SPI_CTAR_PBR(pbr)
 		| SPI_CTAR_BR(br);
 
-- 
2.1.0
