From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove redundant call to lpss_ssp_setup() in probe" to the spi tree
Date: Fri, 20 Nov 2015 18:20:47 +0000
Message-ID: <E1ZzqIh-00041w-4X@debutante>
References: <1448020521-94914-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448020521-94914-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove redundant call to lpss_ssp_setup() in probe

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

>From d599af65fda384b5e91780485f243c9f2d3e757d Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 20 Nov 2015 13:55:21 +0200
Subject: [PATCH] spi: pxa2xx: Remove redundant call to lpss_ssp_setup() in
 probe

Commit 8b136baa5892 ("spi: pxa2xx: Detect number of enabled Intel LPSS SPI
chip select signals") added a block where lpss_ssp_setup() gets called
again for Intel LPSS SPI host controllers before checking number of chip
selects from the capabilities register.

There is no point in calling the function twice in probe so remove the
first call.

Reported-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b25dc71b0ea9..ab9914ad8365 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1567,9 +1567,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (!is_quark_x1000_ssp(drv_data))
 		pxa2xx_spi_write(drv_data, SSPSP, 0);
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_setup(drv_data);
-
 	if (is_lpss_ssp(drv_data)) {
 		lpss_ssp_setup(drv_data);
 		config = lpss_get_config(drv_data);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
