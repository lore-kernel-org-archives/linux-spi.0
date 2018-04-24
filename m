From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Allow 64-bit DMA" to the spi tree
Date: Tue, 24 Apr 2018 16:28:33 +0100
Message-ID: <E1fAzrt-0007ZJ-F6@debutante>
References: <20180419165333.32962-1-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180419165333.32962-1-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Allow 64-bit DMA

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

>From efc4a13724b852ddaa3358402a8dec024ffbcb17 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 19 Apr 2018 19:53:32 +0300
Subject: [PATCH] spi: pxa2xx: Allow 64-bit DMA

Currently the 32-bit device address only is supported for DMA. However,
starting from Intel Sunrisepoint PCH the DMA address of the device FIFO
can be 64-bit.

Change the respective variable to be compatible with DMA engine
expectations, i.e. to phys_addr_t.

Fixes: 34cadd9c1bcb ("spi: pxa2xx: Add support for Intel Sunrisepoint")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-pxa2xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 513ec6c6e25b..0ae7defd3492 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -38,7 +38,7 @@ struct driver_data {
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
-	u32 ssdr_physical;
+	phys_addr_t ssdr_physical;
 
 	/* SSP masks*/
 	u32 dma_cr1;
-- 
2.17.0
