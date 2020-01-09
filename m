From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835: Raise maximum number of slaves to 4" to the spi tree
Date: Thu, 09 Jan 2020 21:31:07 +0000
Message-ID: <applied-01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
References: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835: Raise maximum number of slaves to 4

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From 603e92ff10a81b965ac41dc9fb3d287408e834fb Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Date: Thu, 9 Jan 2020 13:23:41 +0100
Subject: [PATCH] spi: bcm2835: Raise maximum number of slaves to 4

The "RevPi Connect Flat" PLC offered by KUNBUS has 4 slaves attached
to the BCM2835 SPI master.  Raise the maximum number of slaves in the
driver accordingly.

Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
Link: https://lore.kernel.org/r/01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b784c9fdf9ec..11c235879bb7 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,7 @@
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
-#define BCM2835_SPI_NUM_CS		3   /* raise as necessary */
+#define BCM2835_SPI_NUM_CS		4   /* raise as necessary */
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
-- 
2.20.1
