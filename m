From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: add missed break" to the spi tree
Date: Wed, 04 Jan 2017 18:37:21 +0000
Message-ID: <E1cOqR7-00021c-Ds@debutante>
References: <20170102114429.128094-1-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170102114429.128094-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: add missed break

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

>From a2dd8af00ca7fff4972425a4a6b19dd1840dc807 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 2 Jan 2017 13:44:28 +0200
Subject: [PATCH] spi: pxa2xx: add missed break

The commit 7c7289a40425 ("spi: pxa2xx: Default thresholds to PXA
configuration") while splitting up CE4100 code obviously missed a break
condition in one chunk. Add it here.

Looks like we have no active user of CE4100, though better to fix this later
than never.

Fixes: commit 7c7289a40425 ("spi: pxa2xx: Default thresholds to PXA configuration")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dd7b5b47291d..d6239fa718be 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1690,6 +1690,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 		tmp = SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
+		break;
 	default:
 		tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
 		      SSCR1_TxTresh(TX_THRESH_DFLT);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
