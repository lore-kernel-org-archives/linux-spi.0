From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: st-ssc4: whitespace cleanup" to the spi tree
Date: Fri, 26 May 2017 12:42:11 +0100
Message-ID: <E1dEDdD-0000qF-SE@debutante>
References: <20170525040505.30633-1-chris.packham@alliedtelesis.co.nz>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525040505.30633-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: st-ssc4: whitespace cleanup

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

>From 0b0cda4102de7a3dbcedfb5f943a5d08e4ec8500 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Thu, 25 May 2017 16:05:05 +1200
Subject: [PATCH] spi: st-ssc4: whitespace cleanup

Remove stray single spaces after a leading hard-tab.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e54b59638458..a4e43fc19ece 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -229,42 +229,42 @@ static int spi_st_setup(struct spi_device *spi)
 		"setting baudrate:target= %u hz, actual= %u hz, sscbrg= %u\n",
 		hz, spi_st->baud, sscbrg);
 
-	 /* Set SSC_CTL and enable SSC */
-	 var = readl_relaxed(spi_st->base + SSC_CTL);
-	 var |= SSC_CTL_MS;
+	/* Set SSC_CTL and enable SSC */
+	var = readl_relaxed(spi_st->base + SSC_CTL);
+	var |= SSC_CTL_MS;
 
-	 if (spi->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL)
 		var |= SSC_CTL_PO;
-	 else
+	else
 		var &= ~SSC_CTL_PO;
 
-	 if (spi->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		var |= SSC_CTL_PH;
-	 else
+	else
 		var &= ~SSC_CTL_PH;
 
-	 if ((spi->mode & SPI_LSB_FIRST) == 0)
+	if ((spi->mode & SPI_LSB_FIRST) == 0)
 		var |= SSC_CTL_HB;
-	 else
+	else
 		var &= ~SSC_CTL_HB;
 
-	 if (spi->mode & SPI_LOOP)
+	if (spi->mode & SPI_LOOP)
 		var |= SSC_CTL_LPB;
-	 else
+	else
 		var &= ~SSC_CTL_LPB;
 
-	 var &= ~SSC_CTL_DATA_WIDTH_MSK;
-	 var |= (spi->bits_per_word - 1);
+	var &= ~SSC_CTL_DATA_WIDTH_MSK;
+	var |= (spi->bits_per_word - 1);
 
-	 var |= SSC_CTL_EN_TX_FIFO | SSC_CTL_EN_RX_FIFO;
-	 var |= SSC_CTL_EN;
+	var |= SSC_CTL_EN_TX_FIFO | SSC_CTL_EN_RX_FIFO;
+	var |= SSC_CTL_EN;
 
-	 writel_relaxed(var, spi_st->base + SSC_CTL);
+	writel_relaxed(var, spi_st->base + SSC_CTL);
 
-	 /* Clear the status register */
-	 readl_relaxed(spi_st->base + SSC_RBUF);
+	/* Clear the status register */
+	readl_relaxed(spi_st->base + SSC_RBUF);
 
-	 return 0;
+	return 0;
 
 out_free_gpio:
 	gpio_free(cs);
-- 
2.11.0
