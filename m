From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835aux: fix bitmask defines" to the spi tree
Date: Wed, 10 Feb 2016 12:55:05 +0000
Message-ID: <E1aTUIT-00050f-Cn@debutante>
References: <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-2-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835aux: fix bitmask defines

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

>From fe0e2304f560f81c1673711ac3f9a8c7c3cbb8be Mon Sep 17 00:00:00 2001
From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Date: Tue, 9 Feb 2016 19:10:32 +0100
Subject: [PATCH] spi: bcm2835aux: fix bitmask defines

The bitmasks for txempty and idle interrupts were interchanged.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7de6f8472a81..ecc73c0a97cf 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -73,8 +73,8 @@
 
 /* Bitfields in CNTL1 */
 #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
-#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
-#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040
+#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
+#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
 #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
 #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
