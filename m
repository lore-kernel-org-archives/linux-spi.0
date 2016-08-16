From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: fix a possible NULL dereference" to the spi tree
Date: Tue, 16 Aug 2016 12:30:33 +0100
Message-ID: <E1bZcZl-0004o1-Fa@debutante>
References: <1471341021-22522-2-git-send-email-clabbe.montjoie@gmail.com>
Cc: coverity-GFdadSzt00ze9xe1eoZjHA@public.gmane.org (CID 1324129),
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471341021-22522-2-git-send-email-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: fix a possible NULL dereference

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

>From 53d89160753c7d32bb82d3bed980fd3dc3f2538a Mon Sep 17 00:00:00 2001
From: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 16 Aug 2016 11:50:21 +0200
Subject: [PATCH] spi: spi-fsl-dspi: fix a possible NULL dereference

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Reported-by: coverity (CID 1324129)
Signed-off-by: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ab6b9e1f79a3..d57baf6c2d1e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -651,8 +651,6 @@ static int dspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	int ret = 0, cs_num, bus_num;
-	const struct of_device_id *of_id =
-			of_match_device(fsl_dspi_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!master)
@@ -686,7 +684,7 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	master->bus_num = bus_num;
 
-	dspi->devtype_data = of_id->data;
+	dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 	if (!dspi->devtype_data) {
 		dev_err(&pdev->dev, "can't get devtype_data\n");
 		ret = -EFAULT;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
