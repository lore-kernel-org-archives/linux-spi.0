From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: replace schedule() with cond_resched()" to the spi tree
Date: Fri, 25 Nov 2016 13:10:31 +0000
Message-ID: <E1cAGGt-0005I7-G0@debutante>
References: <1479985484-6641-1-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479985484-6641-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: replace schedule() with cond_resched()

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

>From 14de3918eacfc624023775c319e85e6597514195 Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 24 Nov 2016 19:04:42 +0800
Subject: [PATCH] spi: imx: replace schedule() with cond_resched()

It's more rational that just do the schedule when necessary
other than do it every time. Thus, it's better to replace
schedule() with cond_resched() in fsl_lpspi_txfifo_empty(),
which contributes to saving cpu time.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 18a269d2e2f8..539c971b9f05 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -176,7 +176,7 @@ static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi)
 			dev_dbg(fsl_lpspi->dev, "txfifo empty timeout\n");
 			return -ETIMEDOUT;
 		}
-		schedule();
+		cond_resched();
 
 	} while (txcnt);
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
