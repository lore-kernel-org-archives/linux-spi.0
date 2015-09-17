From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bitbang: Replace spinlock by mutex" to the spi tree
Date: Thu, 17 Sep 2015 18:37:13 +0100
Message-ID: <E1Zcd7R-0006Xu-Gl@finisterre>
References: <1439783574-5933-1-git-send-email-drinkcat@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439783574-5933-1-git-send-email-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bitbang: Replace spinlock by mutex

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c15f6ed3a18f10cdc33f64906ab353f17a6df114 Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Mon, 17 Aug 2015 11:52:54 +0800
Subject: [PATCH] spi: bitbang: Replace spinlock by mutex

chipselect (in the case of spi-gpio: spi_gpio_chipselect, which
calls gpiod_set_raw_value_cansleep) can sleep, so we should not
hold a spinlock while calling it from spi_bitbang_setup.

This issue was introduced by this commit, which converted spi-gpio
to cansleep variants:
d9dda5a191 "spi: spi-gpio: Use 'cansleep' variants to access GPIO"

Replacing the lock variable by a mutex fixes the issue: This is
safe as all instances where the lock is used are called from
contexts that can sleep.

Finally, update spi-ppc4xx and and spi-s3c24xx to use mutex
functions, as they directly hold the lock for similar purpose.

Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bitbang.c       | 17 +++++++----------
 drivers/spi/spi-ppc4xx.c        |  4 ++--
 drivers/spi/spi-s3c24xx.c       |  4 ++--
 include/linux/spi/spi_bitbang.h |  2 +-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 840a498..ef43ef5 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -180,7 +180,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi->master);
 
@@ -210,12 +209,12 @@ int spi_bitbang_setup(struct spi_device *spi)
 	 */
 
 	/* deselect chip (low or high) */
-	spin_lock_irqsave(&bitbang->lock, flags);
+	mutex_lock(&bitbang->lock);
 	if (!bitbang->busy) {
 		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
 		ndelay(cs->nsecs);
 	}
-	spin_unlock_irqrestore(&bitbang->lock, flags);
+	mutex_unlock(&bitbang->lock);
 
 	return 0;
 }
@@ -255,13 +254,12 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 static int spi_bitbang_prepare_hardware(struct spi_master *spi)
 {
 	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi);
 
-	spin_lock_irqsave(&bitbang->lock, flags);
+	mutex_lock(&bitbang->lock);
 	bitbang->busy = 1;
-	spin_unlock_irqrestore(&bitbang->lock, flags);
+	mutex_unlock(&bitbang->lock);
 
 	return 0;
 }
@@ -378,13 +376,12 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
 {
 	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi);
 
-	spin_lock_irqsave(&bitbang->lock, flags);
+	mutex_lock(&bitbang->lock);
 	bitbang->busy = 0;
-	spin_unlock_irqrestore(&bitbang->lock, flags);
+	mutex_unlock(&bitbang->lock);
 
 	return 0;
 }
@@ -427,7 +424,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	if (!master || !bitbang->chipselect)
 		return -EINVAL;
 
-	spin_lock_init(&bitbang->lock);
+	mutex_init(&bitbang->lock);
 
 	if (!master->mode_bits)
 		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 54fb984..dd3d0a2 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -210,12 +210,12 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	if (in_8(&hw->regs->cdm) != cdm)
 		out_8(&hw->regs->cdm, cdm);
 
-	spin_lock(&hw->bitbang.lock);
+	mutex_lock(&hw->bitbang.lock);
 	if (!hw->bitbang.busy) {
 		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
 		/* Need to ndelay here? */
 	}
-	spin_unlock(&hw->bitbang.lock);
+	mutex_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index f36bc32..4e7d1bf 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -198,12 +198,12 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spin_lock(&hw->bitbang.lock);
+	mutex_lock(&hw->bitbang.lock);
 	if (!hw->bitbang.busy) {
 		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
 		/* need to ndelay for 0.5 clocktick ? */
 	}
-	spin_unlock(&hw->bitbang.lock);
+	mutex_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 85578d4..154788e 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -4,7 +4,7 @@
 #include <linux/workqueue.h>
 
 struct spi_bitbang {
-	spinlock_t		lock;
+	struct mutex		lock;
 	u8			busy;
 	u8			use_dma;
 	u8			flags;		/* extra spi->mode support */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
