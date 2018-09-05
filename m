From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Fix interrupted DMA transfers" to the spi tree
Date: Wed,  5 Sep 2018 12:45:59 +0100 (BST)
Message-ID: <20180905114559.E12A811229D0@debutante.sirena.org.uk>
References: <20180905084939.7401-5-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180905084939.7401-5-geert+renesas@glider.be>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Fix interrupted DMA transfers

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

>From 8dbbaa47b96f6ea5f09f922b4effff3c505cd8cf Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 5 Sep 2018 10:49:39 +0200
Subject: [PATCH] spi: rspi: Fix interrupted DMA transfers

When interrupted, wait_event_interruptible_timeout() returns
-ERESTARTSYS, and the SPI transfer in progress will fail, as expected:

    m25p80 spi0.0: SPI transfer failed: -512
    spi_master spi0: failed to transfer one message from queue

However, as the underlying DMA transfers may not have completed, all
subsequent SPI transfers may start to fail:

    spi_master spi0: receive timeout
    qspi_transfer_out_in() returned -110
    m25p80 spi0.0: SPI transfer failed: -110
    spi_master spi0: failed to transfer one message from queue

Fix this by calling dmaengine_terminate_all() not only for timeouts, but
also for errors.

This can be reproduced on r8a7991/koelsch, using "hd /dev/mtd0" followed
by CTRL-C.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-rspi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f93a4587e3fb..b37de1d991d6 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -598,11 +598,13 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 	ret = wait_event_interruptible_timeout(rspi->wait,
 					       rspi->dma_callbacked, HZ);
-	if (ret > 0 && rspi->dma_callbacked)
+	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
-	else if (!ret) {
-		dev_err(&rspi->master->dev, "DMA timeout\n");
-		ret = -ETIMEDOUT;
+	} else {
+		if (!ret) {
+			dev_err(&rspi->master->dev, "DMA timeout\n");
+			ret = -ETIMEDOUT;
+		}
 		if (tx)
 			dmaengine_terminate_all(rspi->master->dma_tx);
 		if (rx)
-- 
2.19.0.rc1
