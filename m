From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Remove duplicate code to check chip_select
Date: Tue, 11 Feb 2014 22:07:30 +0800
Message-ID: <1392127650.9833.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In spi_add_device(), we have the code to validate spi->chip_select.
So remove the duplicate code in various drivers.

Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Cc: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-atmel.c         | 7 -------
 drivers/spi/spi-coldfire-qspi.c | 6 ------
 drivers/spi/spi-falcon.c        | 3 ---
 drivers/spi/spi-mpc52xx.c       | 3 ---
 drivers/spi/spi-omap-uwire.c    | 6 ------
 drivers/spi/spi-tegra114.c      | 2 --
 drivers/spi/spi-tegra20-slink.c | 2 --
 7 files changed, 29 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 88796df..c3ed7ed 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -992,13 +992,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 
 	as = spi_master_get_devdata(spi->master);
 
-	if (spi->chip_select > spi->master->num_chipselect) {
-		dev_dbg(&spi->dev,
-				"setup: invalid chipselect %u (%u defined)\n",
-				spi->chip_select, spi->master->num_chipselect);
-		return -EINVAL;
-	}
-
 	/* see notes above re chipselect */
 	if (!atmel_spi_is_v2(as)
 			&& spi->chip_select == 0
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index cabed8f..0ab2c55 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -356,12 +356,6 @@ static int mcfqspi_transfer_one_message(struct spi_master *master,
 
 static int mcfqspi_setup(struct spi_device *spi)
 {
-	if (spi->chip_select >= spi->master->num_chipselect) {
-		dev_dbg(&spi->dev, "%d chip select is out of range\n",
-			spi->chip_select);
-		return -EINVAL;
-	}
-
 	mcfqspi_cs_deselect(spi_master_get_devdata(spi->master),
 			    spi->chip_select, spi->mode & SPI_CS_HIGH);
 
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index dd5bd46..0ae7f45 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -312,9 +312,6 @@ static int falcon_sflash_setup(struct spi_device *spi)
 	unsigned int i;
 	unsigned long flags;
 
-	if (spi->chip_select > 0)
-		return -ENODEV;
-
 	spin_lock_irqsave(&ebu_lock, flags);
 
 	if (spi->max_speed_hz >= CLOCK_100M) {
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index f573c3c..bd404c2 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -364,9 +364,6 @@ static int mpc52xx_spi_setup(struct spi_device *spi)
 	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST))
 		return -EINVAL;
 
-	if (spi->chip_select >= spi->master->num_chipselect)
-		return -EINVAL;
-
 	return 0;
 }
 
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 9313fd3..462ddd4 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -332,12 +332,6 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	uwire = spi_master_get_devdata(spi->master);
 
-	if (spi->chip_select > 3) {
-		pr_debug("%s: cs%d?\n", dev_name(&spi->dev), spi->chip_select);
-		status = -ENODEV;
-		goto done;
-	}
-
 	bits = spi->bits_per_word;
 	if (t != NULL && t->bits_per_word)
 		bits = t->bits_per_word;
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 2f8aba5..3d10ece 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -759,8 +759,6 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
-	BUG_ON(spi->chip_select >= MAX_CHIP_SELECT);
-
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 9a060aa..8e21651 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -759,8 +759,6 @@ static int tegra_slink_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
-	BUG_ON(spi->chip_select >= MAX_CHIP_SELECT);
-
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
