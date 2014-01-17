From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Remove duplicate code to set default bits_per_word
 setting
Date: Fri, 17 Jan 2014 18:53:40 +0800
Message-ID: <1389956020.6412.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The implementation in spi_setup() already set spi->bits_per_word = 8 when
spi->bits_per_word is 0 before calling spi->master->setup.
So we don't need to do it again in setup() callback.

Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-davinci.c      | 4 ----
 drivers/spi/spi-fsl-dspi.c     | 3 ---
 drivers/spi/spi-mxs.c          | 9 ---------
 drivers/spi/spi-rspi.c         | 2 --
 drivers/spi/spi-sc18is602.c    | 3 ---
 drivers/spi/spi-sh.c           | 3 ---
 drivers/spi/spi-sirf.c         | 7 -------
 drivers/spi/spi-topcliff-pch.c | 6 ------
 8 files changed, 37 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 79d40c8..5e7389f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -396,10 +396,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
-	/* if bits per word length is zero then set it default 8 */
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (!(spi->mode & SPI_NO_CS)) {
 		if ((pdata->chip_sel == NULL) ||
 		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a37f156..ec79f72 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -375,9 +375,6 @@ static int dspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	return dspi_setup_transfer(spi, NULL);
 }
 
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 3adebfa..79e5aa2 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -111,14 +111,6 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 	return 0;
 }
 
-static int mxs_spi_setup(struct spi_device *dev)
-{
-	if (!dev->bits_per_word)
-		dev->bits_per_word = 8;
-
-	return 0;
-}
-
 static u32 mxs_spi_cs_to_reg(unsigned cs)
 {
 	u32 select = 0;
@@ -502,7 +494,6 @@ static int mxs_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	master->transfer_one_message = mxs_spi_transfer_one;
-	master->setup = mxs_spi_setup;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->num_chipselect = 3;
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c26840c..28987d9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -802,8 +802,6 @@ static int rspi_setup(struct spi_device *spi)
 {
 	struct rspi_data *rspi = spi_master_get_devdata(spi->master);
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
 	rspi->max_speed_hz = spi->max_speed_hz;
 
 	rspi->spcmd = SPCMD_SSLKP;
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index c981d21..121c2e1 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -247,9 +247,6 @@ error:
 
 static int sc18is602_setup(struct spi_device *spi)
 {
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->mode & ~(SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST))
 		return -EINVAL;
 
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 9fea8cc..f6f2c70 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -352,9 +352,6 @@ static int spi_sh_setup(struct spi_device *spi)
 {
 	struct spi_sh_data *ss = spi_master_get_devdata(spi->master);
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	pr_debug("%s: enter\n", __func__);
 
 	spi_sh_write(ss, 0xfe, SPI_SH_CR1);	/* SPI sycle stop */
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index ed5e501..e430689 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -536,16 +536,9 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 static int spi_sirfsoc_setup(struct spi_device *spi)
 {
-	struct sirfsoc_spi *sspi;
-
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
-	sspi = spi_master_get_devdata(spi->master);
-
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	return spi_sirfsoc_setup_transfer(spi, NULL);
 }
 
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 338fc11..2e7f38c 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -466,12 +466,6 @@ static void pch_spi_reset(struct spi_master *master)
 
 static int pch_spi_setup(struct spi_device *pspi)
 {
-	/* check bits per word */
-	if (pspi->bits_per_word == 0) {
-		pspi->bits_per_word = 8;
-		dev_dbg(&pspi->dev, "%s 8 bits per word\n", __func__);
-	}
-
 	/* Check baud rate setting */
 	/* if baud rate of chip is greater than
 	   max we can support,return error */
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
