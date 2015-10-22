From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Align a few defines" to the spi tree
Date: Fri, 23 Oct 2015 08:57:16 +0900
Message-ID: <E1ZpPjQ-0002yX-3X@finisterre>
References: <1445521485-2029-5-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-5-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Align a few defines

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

>From ceb941afa5c38dae8e273089266c412d362c7963 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 22 Oct 2015 16:44:43 +0300
Subject: [PATCH] spi: pxa2xx: Align a few defines

Add more indentation to define lines for making them aligned with the
longest one. They would look messy after adding more long defines.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4dc5660..0f6a6c8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -61,9 +61,9 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 				| QUARK_X1000_SSCR1_TFT		\
 				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
 
-#define GENERAL_REG_RXTO_HOLDOFF_DISABLE BIT(24)
-#define SPI_CS_CONTROL_SW_MODE	BIT(0)
-#define SPI_CS_CONTROL_CS_HIGH	BIT(1)
+#define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
+#define SPI_CS_CONTROL_SW_MODE			BIT(0)
+#define SPI_CS_CONTROL_CS_HIGH			BIT(1)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
