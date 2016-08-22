From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Drop extra spi_master_put in device remove function" to the spi tree
Date: Mon, 22 Aug 2016 18:59:41 +0100
Message-ID: <E1bbtVd-00011K-5x@debutante>
References: <1471706732-25944-1-git-send-email-weiyj.lk@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471706732-25944-1-git-send-email-weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Drop extra spi_master_put in device remove function

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

>From 6999aeabbb703a81a204cb6f9f8f151759a99ac4 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 20 Aug 2016 15:25:32 +0000
Subject: [PATCH] spi: spi-fsl-dspi: Drop extra spi_master_put in device remove
 function

The call sequence spi_alloc_master/spi_register_master/spi_unregister_master
is complete; it reduces the device reference count to zero, which and results
in device memory being freed. The subsequent call to spi_master_put is
unnecessary and results in an access to free memory. Drop it.

Fixes: 9298bc727385 ("spi: spi-fsl-dspi: Remove spi-bitbang")
Signed-off-by: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 95d8b929cd52..35c0dd945668 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -763,7 +763,6 @@ static int dspi_remove(struct platform_device *pdev)
 	/* Disconnect from the SPI framework */
 	clk_disable_unprepare(dspi->clk);
 	spi_unregister_master(dspi->master);
-	spi_master_put(dspi->master);
 
 	return 0;
 }
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
