From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] spi: sh-msiof: per-transaction runtime PM
Date: Wed, 14 Mar 2012 18:35:58 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently the spi-sh-msiof driver implements a runtime PM scheme, based on
chipselect toggling. However, this is largely inefficient, since SPI
client drivers are allowed to keep the chipselect active for long periods
of time. This patch allows the driver to runtime-suspend the controller
between SPI transfers. While moving runtime-PM hooks this patch also 
removes manual PM clock manipulation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Marked as RFC, because I'm actually not sure, whether suspending after 
each transfer is actually allowed. This seems to bring problems with 
mmc-spi at least. Some commands return errors, but a retry recovers. More 
investigation is required. Any hints concerning why this is not perfectly 
functioning would be appreciated!

 drivers/spi/spi-sh-msiof.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1f466bc..ece38c2 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -397,7 +397,6 @@ static int sh_msiof_spi_setup_transfer(struct spi_device *spi,
 
 static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 {
-	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
 	int value;
 
 	/* chip select is active low unless SPI_CS_HIGH is set */
@@ -406,28 +405,8 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 	else
 		value = (is_on == BITBANG_CS_ACTIVE) ? 0 : 1;
 
-	if (is_on == BITBANG_CS_ACTIVE) {
-		if (!test_and_set_bit(0, &p->flags)) {
-			pm_runtime_get_sync(&p->pdev->dev);
-			clk_enable(p->clk);
-		}
-
-		/* Configure pins before asserting CS */
-		sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
-					  !!(spi->mode & SPI_CPHA),
-					  !!(spi->mode & SPI_3WIRE),
-					  !!(spi->mode & SPI_LSB_FIRST));
-	}
-
 	/* use spi->controller data for CS (same strategy as spi_gpio) */
 	gpio_set_value((unsigned)spi->controller_data, value);
-
-	if (is_on == BITBANG_CS_INACTIVE) {
-		if (test_and_clear_bit(0, &p->flags)) {
-			clk_disable(p->clk);
-			pm_runtime_put(&p->pdev->dev);
-		}
-	}
 }
 
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
@@ -560,6 +539,14 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 			rx_fifo = sh_msiof_spi_read_fifo_32;
 	}
 
+	pm_runtime_get_sync(&p->pdev->dev);
+
+	/* Configure pins before asserting CS */
+	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
+				  !!(spi->mode & SPI_CPHA),
+				  !!(spi->mode & SPI_3WIRE),
+				  !!(spi->mode & SPI_LSB_FIRST));
+
 	/* setup clocks (clock already enabled in chipselect()) */
 	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk),
 				  sh_msiof_spi_hz(spi, t));
@@ -582,6 +569,7 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 		words -= n;
 	}
 
+	pm_runtime_put(&p->pdev->dev);
 	return bytes_done;
 }
 
-- 
1.7.2.5

