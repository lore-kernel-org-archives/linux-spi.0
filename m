From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xxx: change "no DMA channels..." msg from debug to warning" to the spi tree
Date: Mon,  8 Apr 2019 14:32:41 +0700 (+07)
Message-ID: <20190408073241.EEC2C441D3C@finisterre.ee.mobilebroadband>
References: <1554468022-17416-1-git-send-email-f.suligoi@asem.it>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554468022-17416-1-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xxx: change "no DMA channels..." msg from debug to warning

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

>From 8b57b11bc45ee512566513259cd3c302df3c9dae Mon Sep 17 00:00:00 2001
From: Flavio Suligoi <f.suligoi@asem.it>
Date: Fri, 5 Apr 2019 14:40:22 +0200
Subject: [PATCH] spi: pxa2xxx: change "no DMA channels..." msg from debug to
 warning

Change the type of the diagnostic message:

"no DMA channels available, using PIO"

from debug to warning.

The lack of an available DMA channel is very important regard the
spi-pxa2xx performance. The transfer speed can be reduced more than 50%.

So it is very important to warn the user about this, without enabling
the full SPI debug with CONFIG_SPI_DEBUG.

Moreover, enabling the full SPI debug only to enable this specific
debug message, the dmesg buffer fills quickly with a lot of
repetitive information during the SPI data transfer.
This cause the loss of all the first important messages
written during the initialization.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6160fe0ce7ab..f7068ccfe7d2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1696,7 +1696,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
-			dev_dbg(dev, "no DMA channels available, using PIO\n");
+			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
-- 
2.20.1
