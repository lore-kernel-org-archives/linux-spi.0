From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: armada-3700: Set mode bits correctly" to the spi tree
Date: Fri, 16 Dec 2016 12:31:53 +0000
Message-ID: <E1cHrg1-0006LK-I7@debutante>
References: <20161216093325.GA13942@elgon.mountain>
Cc: Romain Perier <romain.perier@free-electrons.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Romain Perier <romain.perier@free-electrons.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161216093325.GA13942@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: armada-3700: Set mode bits correctly

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

>From 42cd4ed888393b2bc8ddfd277aa2d0ec0c7e0259 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 16 Dec 2016 12:33:25 +0300
Subject: [PATCH] spi: armada-3700: Set mode bits correctly

We set SPI_RX_DUAL twice instead of setting SPI_TX_DUAL.

Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Romain Perier <romain.perier@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 4e921782652f..0314c6b9e044 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -825,7 +825,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	master->unprepare_message = a3700_spi_unprepare_message;
 	master->set_cs = a3700_spi_set_cs;
 	master->flags = SPI_MASTER_HALF_DUPLEX;
-	master->mode_bits |= (SPI_RX_DUAL | SPI_RX_DUAL |
+	master->mode_bits |= (SPI_RX_DUAL | SPI_TX_DUAL |
 			      SPI_RX_QUAD | SPI_TX_QUAD);
 
 	platform_set_drvdata(pdev, master);
-- 
2.11.0

