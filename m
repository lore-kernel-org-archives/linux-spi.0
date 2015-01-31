From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: fsl-dspi: Remove possible memory leak of 'chip'
Date: Sat, 31 Jan 2015 22:03:25 +0530
Message-ID: <1422722005-1616-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stefan-XLVq0VzYD2Y@public.gmane.org>, <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move the check for spi->bits_per_word
before allocation, to avoid memory leak.

Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4cda994..604b6d3 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -339,6 +339,13 @@ static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
 	unsigned char br = 0, pbr = 0, fmsz = 0;
 
+	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
+		fmsz = spi->bits_per_word - 1;
+	} else {
+		pr_err("Invalid wordsize\n");
+		return -ENODEV;
+	}
+
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (chip == NULL) {
@@ -350,12 +357,6 @@ static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
 		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
-	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
-		fmsz = spi->bits_per_word - 1;
-	} else {
-		pr_err("Invalid wordsize\n");
-		return -ENODEV;
-	}
 
 	chip->void_write_data = 0;
 
-- 
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
