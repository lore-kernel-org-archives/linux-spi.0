From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: armada-3700: Remove unnecessary condition" to the spi tree
Date: Fri, 16 Dec 2016 12:31:56 +0000
Message-ID: <E1cHrg4-0006MV-Gt@debutante>
References: <20161216093359.GB13942@elgon.mountain>
Cc: Romain Perier <romain.perier@free-electrons.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Romain Perier <romain.perier@free-electrons.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161216093359.GB13942@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: armada-3700: Remove unnecessary condition

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

>From 0cc059abac0dc687dc714f3ec2c8d8a134132f56 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 16 Dec 2016 12:33:59 +0300
Subject: [PATCH] spi: armada-3700: Remove unnecessary condition

We checked that "a3700_spi->wait_mask & cause" was set at the beginning
of the function so we don't need to check again here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Romain Perier <romain.perier@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 4e921782652f..4e68f34957cc 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -340,8 +340,7 @@ static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
 	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, cause);
 
 	/* Wake up the transfer */
-	if (a3700_spi->wait_mask & cause)
-		complete(&a3700_spi->done);
+	complete(&a3700_spi->done);
 
 	return IRQ_HANDLED;
 }
-- 
2.11.0

