From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:20:40 +0900
Message-ID: <002401ce579f$2ce7fa20$86b7ee60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-davinci.c        |    4 ++--
 drivers/spi/spi-fsl-spi.c        |    2 +-
 drivers/spi/spi-mpc52xx-psc.c    |    2 +-
 drivers/spi/spi-mpc52xx.c        |    4 ++--
 drivers/spi/spi-omap-100k.c      |    4 ++--
 drivers/spi/spi-omap-uwire.c     |    4 ++--
 drivers/spi/spi-omap2-mcspi.c    |    4 ++--
 drivers/spi/spi-orion.c          |    4 ++--
 drivers/spi/spi-ppc4xx.c         |    6 ++----
 drivers/spi/spi-rspi.c           |    4 ++--
 drivers/spi/spi-sh-hspi.c        |    4 ++--
 drivers/spi/spi-sh.c             |    4 ++--
 drivers/spi/spi-tegra114.c       |    4 ++--
 drivers/spi/spi-tegra20-sflash.c |    4 ++--
 drivers/spi/spi-tegra20-slink.c  |    4 ++--
 15 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 50b13c9..968e364 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -865,7 +865,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 
 	dspi = spi_master_get_devdata(master);
 	if (dspi == NULL) {
@@ -1044,7 +1044,7 @@ static int davinci_spi_remove(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *r;
 
-	master = dev_get_drvdata(&pdev->dev);
+	master = platform_get_drvdata(pdev);
 	dspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&dspi->bitbang);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 14e202e..41e89c3 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -853,7 +853,7 @@ err:
 
 static int of_fsl_spi_remove(struct platform_device *ofdev)
 {
-	struct spi_master *master = dev_get_drvdata(&ofdev->dev);
+	struct spi_master *master = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 	int ret;
 
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 291120b..fed0571 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -481,7 +481,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
 
 static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
+	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
 
 	flush_workqueue(mps->workqueue);
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 29f7705..7c675fe 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -438,7 +438,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 	master->dev.of_node = op->dev.of_node;
 
-	dev_set_drvdata(&op->dev, master);
+	platform_set_drvdata(op, master);
 
 	ms = spi_master_get_devdata(master);
 	ms->master = master;
@@ -529,7 +529,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
 static int mpc52xx_spi_remove(struct platform_device *op)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
+	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
 	struct mpc52xx_spi *ms = spi_master_get_devdata(master);
 	int i;
 
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 78d29a1..9236764 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -510,7 +510,7 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	master->num_chipselect = 2;
 	master->mode_bits = MODEBITS;
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 
 	spi100k = spi_master_get_devdata(master);
 	spi100k->master = master;
@@ -569,7 +569,7 @@ static int omap1_spi100k_remove(struct platform_device *pdev)
 	unsigned long		flags;
 	int			status = 0;
 
-	master = dev_get_drvdata(&pdev->dev);
+	master = platform_get_drvdata(pdev);
 	spi100k = spi_master_get_devdata(master);
 
 	spin_lock_irqsave(&spi100k->lock, flags);
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 102b233..a6a8f09 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -495,7 +495,7 @@ static int uwire_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	dev_set_drvdata(&pdev->dev, uwire);
+	platform_set_drvdata(pdev, uwire);
 
 	uwire->ck = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(uwire->ck)) {
@@ -538,7 +538,7 @@ static int uwire_probe(struct platform_device *pdev)
 
 static int uwire_remove(struct platform_device *pdev)
 {
-	struct uwire_spi	*uwire = dev_get_drvdata(&pdev->dev);
+	struct uwire_spi	*uwire = platform_get_drvdata(pdev);
 	int			status;
 
 	// FIXME remove all child devices, somewhere ...
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 000922a..3b5131e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1202,7 +1202,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
@@ -1311,7 +1311,7 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*dma_channels;
 
-	master = dev_get_drvdata(&pdev->dev);
+	master = platform_get_drvdata(pdev);
 	mcspi = spi_master_get_devdata(master);
 	dma_channels = mcspi->dma_channels;
 
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 66a5f82..5d90beb 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -428,7 +428,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = orion_spi_transfer_one_message;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
@@ -485,7 +485,7 @@ static int orion_spi_remove(struct platform_device *pdev)
 	struct resource *r;
 	struct orion_spi *spi;
 
-	master = dev_get_drvdata(&pdev->dev);
+	master = platform_get_drvdata(pdev);
 	spi = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(spi->clk);
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 357f183..8548e57 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -406,7 +406,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (master == NULL)
 		return -ENOMEM;
 	master->dev.of_node = np;
-	dev_set_drvdata(dev, master);
+	platform_set_drvdata(op, master);
 	hw = spi_master_get_devdata(master);
 	hw->master = spi_master_get(master);
 	hw->dev = dev;
@@ -553,7 +553,6 @@ request_mem_error:
 free_gpios:
 	free_gpios(hw);
 free_master:
-	dev_set_drvdata(dev, NULL);
 	spi_master_put(master);
 
 	dev_err(dev, "initialization failed\n");
@@ -562,11 +561,10 @@ free_master:
 
 static int spi_ppc4xx_of_remove(struct platform_device *op)
 {
-	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct spi_master *master = platform_get_drvdata(op);
 	struct ppc4xx_spi *hw = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&hw->bitbang);
-	dev_set_drvdata(&op->dev, NULL);
 	release_mem_region(hw->mapbase, hw->mapsize);
 	free_irq(hw->irqnum, hw);
 	iounmap(hw->regs);
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 902f2fb..b44a6ac 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -719,7 +719,7 @@ static void rspi_release_dma(struct rspi_data *rspi)
 
 static int rspi_remove(struct platform_device *pdev)
 {
-	struct rspi_data *rspi = dev_get_drvdata(&pdev->dev);
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	spi_unregister_master(rspi->master);
 	rspi_release_dma(rspi);
@@ -759,7 +759,7 @@ static int rspi_probe(struct platform_device *pdev)
 	}
 
 	rspi = spi_master_get_devdata(master);
-	dev_set_drvdata(&pdev->dev, rspi);
+	platform_set_drvdata(pdev, rspi);
 
 	rspi->master = master;
 	rspi->addr = ioremap(res->start, resource_size(res));
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 60cfae5..d3a62b9 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -297,7 +297,7 @@ static int hspi_probe(struct platform_device *pdev)
 	}
 
 	hspi = spi_master_get_devdata(master);
-	dev_set_drvdata(&pdev->dev, hspi);
+	platform_set_drvdata(pdev, hspi);
 
 	/* init hspi */
 	hspi->master	= master;
@@ -341,7 +341,7 @@ static int hspi_probe(struct platform_device *pdev)
 
 static int hspi_remove(struct platform_device *pdev)
 {
-	struct hspi_priv *hspi = dev_get_drvdata(&pdev->dev);
+	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 3c3600a..c120a70 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -434,7 +434,7 @@ static irqreturn_t spi_sh_irq(int irq, void *_ss)
 
 static int spi_sh_remove(struct platform_device *pdev)
 {
-	struct spi_sh_data *ss = dev_get_drvdata(&pdev->dev);
+	struct spi_sh_data *ss = platform_get_drvdata(pdev);
 
 	spi_unregister_master(ss->master);
 	destroy_workqueue(ss->workqueue);
@@ -471,7 +471,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	}
 
 	ss = spi_master_get_devdata(master);
-	dev_set_drvdata(&pdev->dev, ss);
+	platform_set_drvdata(pdev, ss);
 
 	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_8BIT:
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 598eb45..e8f542a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1041,7 +1041,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "master allocation failed\n");
 		return -ENOMEM;
 	}
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 	tspi = spi_master_get_devdata(master);
 
 	/* Parse DT */
@@ -1152,7 +1152,7 @@ exit_free_master:
 
 static int tegra_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_master_get_devdata(master);
 
 	free_irq(tspi->irq, tspi);
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 09df8e2..c1d5d95 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -480,7 +480,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->bus_num = -1;
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 	tsd = spi_master_get_devdata(master);
 	tsd->master = master;
 	tsd->dev = &pdev->dev;
@@ -555,7 +555,7 @@ exit_free_master:
 
 static int tegra_sflash_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
 
 	free_irq(tsd->irq, tsd);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 3faf88d..80490cc 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1089,7 +1089,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->bus_num = -1;
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 	tspi = spi_master_get_devdata(master);
 	tspi->master = master;
 	tspi->dev = &pdev->dev;
@@ -1193,7 +1193,7 @@ exit_free_master:
 
 static int tegra_slink_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
 
 	free_irq(tspi->irq, tspi);
-- 
1.7.10.4



------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
