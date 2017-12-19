From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: fixed spin_lock usage inside atmel_spi_remove" to the spi tree
Date: Tue, 19 Dec 2017 11:01:29 +0000
Message-ID: <E1eRFeL-0001Ju-A7@debutante>
References: <1513352417-15275-1-git-send-email-radu.pirea@microchip.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@free-electrons.com, Wenyou.Yang@microchip.com,
        baijiaju1990@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513352417-15275-1-git-send-email-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: fixed spin_lock usage inside atmel_spi_remove

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

>From 66e900a3d225575c8b48b59ae1fe74bb6e5a65cc Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu.pirea@microchip.com>
Date: Fri, 15 Dec 2017 17:40:17 +0200
Subject: [PATCH] spi: atmel: fixed spin_lock usage inside atmel_spi_remove

The only part of atmel_spi_remove which needs to be atomic is hardware
reset.

atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
enabled.
atmel_spi_release_dma calls dma_release_channel and dma_release_channel
locks a mutex inside of spin_lock.

So the call of these functions can't be inside a spin_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f95da364c283..669470971023 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1661,12 +1661,12 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* reset the hardware and block queue progress */
-	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
 		atmel_spi_stop_dma(master);
 		atmel_spi_release_dma(master);
 	}
 
+	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
-- 
2.15.1
