From: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Subject: [RFC / PATCH] [SPI] get_module while using it.
Date: Mon, 14 Apr 2008 21:45:49 +0200
Message-ID: <20080414194549.GA1363@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Without this it is possible to unload the SPI-driver while an
spidev user open()ed the spidev device.

Signed-off-by: Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/spi/atmel_spi.c       |    1 +
 drivers/spi/mpc52xx_psc_spi.c |    1 +
 drivers/spi/omap2_mcspi.c     |    1 +
 drivers/spi/pxa2xx_spi.c      |    1 +
 drivers/spi/spi_bfin5xx.c     |    1 +
 drivers/spi/spi_bitbang.c     |    2 ++
 drivers/spi/spi_imx.c         |    1 +
 drivers/spi/spi_txx9.c        |    1 +
 drivers/spi/spidev.c          |    3 ++-
 include/linux/spi/spi.h       |    1 +
 10 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 1749a27..e5dd509 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -756,6 +756,7 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
 			(unsigned long)regs->start, irq);
 
+	master->owner = THIS_MODULE;
 	ret = spi_register_master(master);
 	if (ret)
 		goto out_reset_hw;
diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 9072946..c4fe30e 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -446,6 +446,7 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_irq;
 	}
 
+	master->owner = THIS_MODULE;
 	ret = spi_register_master(master);
 	if (ret < 0)
 		goto unreg_master;
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b1cc148..0de7a59 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1042,6 +1042,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	if (omap2_mcspi_reset(mcspi) < 0)
 		goto err4;
 
+	master->owner = THIS_MODULE;
 	status = spi_register_master(master);
 	if (status < 0)
 		goto err4;
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 147e26a..d59443a 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1452,6 +1452,7 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
+	master->owner = THIS_MODULE;
 	status = spi_register_master(master);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi master\n");
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index a9ac1fd..019e001 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1302,6 +1302,7 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
+	master->owner = THIS_MODULE;
 	status = spi_register_master(master);
 	if (status != 0) {
 		dev_err(dev, "problem registering spi master\n");
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 71e8814..e589428 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -481,6 +481,8 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 		goto err1;
 	}
 
+	bitbang->master->owner = THIS_MODULE;
+
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
 	 */
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index d4ba640..9a2f74d 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -1588,6 +1588,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
+	master->owner = THIS_MODULE;
 	status = spi_register_master(master);
 	if (status != 0) {
 		dev_err(&pdev->dev, "probe - problem registering spi master\n");
diff --git a/drivers/spi/spi_txx9.c b/drivers/spi/spi_txx9.c
index 2296f37..9619a10 100644
--- a/drivers/spi/spi_txx9.c
+++ b/drivers/spi/spi_txx9.c
@@ -413,6 +413,7 @@ static int __init txx9spi_probe(struct platform_device *dev)
 		 (unsigned long long)res->start, irq,
 		 (c->baseclk + 500000) / 1000000);
 
+	master->owner = THIS_MODULE;
 	master->bus_num = dev->id;
 	master->setup = txx9spi_setup;
 	master->transfer = txx9spi_transfer;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index a9bbf12..622f907 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -401,7 +401,7 @@ static int spidev_open(struct inode *inode, struct file *filp)
 			break;
 		}
 	}
-	if (status == 0) {
+	if (status == 0 && try_module_get(spidev->spi->master->owner)) {
 		if (!spidev->buffer) {
 			spidev->buffer = kmalloc(bufsiz, GFP_KERNEL);
 			if (!spidev->buffer) {
@@ -434,6 +434,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		kfree(spidev->buffer);
 		spidev->buffer = NULL;
 	}
+	module_put(spidev->spi->master->owner);
 	mutex_unlock(&device_list_lock);
 
 	return status;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 920e837..0871b06 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -224,6 +224,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  */
 struct spi_master {
 	struct device	dev;
+	struct module *owner;
 
 	/* other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
