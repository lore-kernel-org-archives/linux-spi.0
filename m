From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: s3c64xx: extend driver to make full use of runtime PM autosuspend" to the spi tree
Date: Mon, 14 Sep 2015 19:54:39 +0100
Message-ID: <E1ZbYtj-0002MG-K9@finisterre>
References: <55D76003.8070608@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D76003.8070608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: s3c64xx: extend driver to make full use of runtime PM autosuspend

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

>From 483867ee2070e045eb0a18fb7bb2f79d2433339f Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 3 Sep 2015 22:39:36 +0200
Subject: [PATCH] spi: s3c64xx: extend driver to make full use of runtime PM
 autosuspend

Extend the driver to make full use of runtime PM autosuspend.
Before only the SPI core was instructed to use autosuspend
by setting master->auto_runtime_pm. Nevertheless due to the missing
pm_runtime_use_autosuspend call autosuspend wasn't active.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8a6ab88..d117fa6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -32,6 +32,7 @@
 #define MAX_SPI_PORTS		6
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
+#define AUTOSUSPEND_TIMEOUT	2000
 
 /* Registers and bit-fields */
 
@@ -859,13 +860,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		}
 	}
 
-	pm_runtime_put(&sdd->pdev->dev);
+	pm_runtime_mark_last_busy(&sdd->pdev->dev);
+	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
 		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 	return 0;
 
 setup_exit:
-	pm_runtime_put(&sdd->pdev->dev);
+	pm_runtime_mark_last_busy(&sdd->pdev->dev);
+	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
 	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
 		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
@@ -1162,6 +1165,12 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* Setup Deufult Mode */
 	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
@@ -1180,13 +1189,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
-		goto err4;
+		goto err3;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
@@ -1195,12 +1201,16 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
-err4:
+err3:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-err3:
+
 	clk_disable_unprepare(sdd->src_clk);
 err2:
 	clk_disable_unprepare(sdd->clk);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
