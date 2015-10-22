From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Save other reg_cs_ctrl bits when configuring chip select" to the spi tree
Date: Fri, 23 Oct 2015 08:57:18 +0900
Message-ID: <E1ZpPjS-0002z4-7x@finisterre>
References: <1445521485-2029-4-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-4-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Save other reg_cs_ctrl bits when configuring chip select

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

>From 0e8972187971ac6c29a9e5899fa6c555c739237c Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 22 Oct 2015 16:44:42 +0300
Subject: [PATCH] spi: pxa2xx: Save other reg_cs_ctrl bits when configuring
 chip select

Upcoming Intel platforms use LPSS SPI_CS_CONTROL register bits 15:12 for
configuring the chip select polarities. Touch only chip select SW mode and
state bits when enabling the software chip select control in order to not
clear any other bits in the register.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index db9016b..4dc5660 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -249,7 +249,9 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	drv_data->lpss_base = drv_data->ioaddr + config->offset;
 
 	/* Enable software chip select control */
-	value = SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH;
+	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
+	value &= ~(SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH);
+	value |= SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH;
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 
 	/* Enable multiblock DMA transfers */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
