From: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] fix SPI bitbang drivers'
	.setup_transfer() method
Date: Tue, 30 Dec 2008 12:45:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812301243030.4059@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Multiple SPI bitbang drivers do not verify t->bits_per_word and 
t->speed_hz for != 0 in their .setup_transfer() methods. Fix them.

Signed-off-by: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
---
diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
index b02f25c..3ab3728 100644
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -237,8 +237,8 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	unsigned bpw, hz;
 	u32 cfg, stat;
 
-	bpw = t ? t->bits_per_word : spi->bits_per_word;
-	hz = t ? t->speed_hz : spi->max_speed_hz;
+	bpw = t && t->bits_per_word ? t->bits_per_word : spi->bits_per_word;
+	hz = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 
 	if (bpw < 4 || bpw > 24) {
 		dev_err(&spi->dev, "setupxfer: invalid bits_per_word=%d\n",
diff --git a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
index 256d183..39c3f4d 100644
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -112,8 +112,8 @@ static int s3c24xx_spi_setupxfer(struct spi_device *spi,
 	unsigned int hz;
 	unsigned int div;
 
-	bpw = t ? t->bits_per_word : spi->bits_per_word;
-	hz  = t ? t->speed_hz : spi->max_speed_hz;
+	bpw = t && t->bits_per_word ? t->bits_per_word : spi->bits_per_word;
+	hz  = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 
 	if (bpw != 8) {
 		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 68d6f49..bee1792 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -147,8 +147,8 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 	u32 hz;
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
 
-	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
-	hz = (t) ? t->speed_hz : spi->max_speed_hz;
+	bits_per_word = t && t->bits_per_word ? t->bits_per_word : spi->bits_per_word;
+	hz = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 	if (bits_per_word != 8) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
 			__func__, bits_per_word);

------------------------------------------------------------------------------
