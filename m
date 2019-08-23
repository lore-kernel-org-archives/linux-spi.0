From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours" to the spi tree
Date: Fri, 23 Aug 2019 12:02:27 +0100 (BST)
Message-ID: <20190823110227.36BDAD02CD1@fitzroy.sirena.org.uk>
References: <20190822211514.19288-3-olteanv@gmail.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190822211514.19288-3-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 37b4100180641968056cb4e034cebc38338e8652 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 23 Aug 2019 00:15:11 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not
 ours

The DSPI interrupt can be shared between two controllers at least on the
LX2160A. In that case, the driver for one controller might misbehave and
consume the other's interrupt. Fix this by actually checking if any of
the bits in the status register have been asserted.

Fixes: 13aed2392741 ("spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190822211514.19288-3-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c90db7db4121..6ef2279a3699 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -659,7 +659,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
 	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	/* Get transfer counter (in number of SPI transfers). It was
 	 * reset to 0 when transfer(s) were started.
-- 
2.20.1
