From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: export dw_spi_set_cs" to the spi tree
Date: Mon, 30 Jul 2018 12:05:06 +0100 (BST)
Message-ID: <20180730110506.5931F1124216@debutante.sirena.org.uk>
References: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        linux-spi@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: export dw_spi_set_cs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c79bdbb490a1d05c6169cbffd37c19f5aa96587a Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 27 Jul 2018 21:53:54 +0200
Subject: [PATCH] spi: dw: export dw_spi_set_cs

Export dw_spi_set_cs so it can be used from the various IP integration
modules.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0d8ccb8be5ec..683a4f137a25 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static void dw_spi_set_cs(struct spi_device *spi, bool enable)
+void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
@@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 }
+EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 446013022849..0168b08364d5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -245,6 +245,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
+extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.18.0
