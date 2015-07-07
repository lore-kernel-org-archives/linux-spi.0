From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/s3c24xx: remove unnecessary memset of s3c24xx_spi" to the spi tree
Date: Tue, 07 Jul 2015 14:58:49 +0100
Message-ID: <E1ZCTOb-0005nU-EZ@finisterre>
References: <1435687438.27701.12.camel@ceres>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435687438.27701.12.camel@ceres>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/s3c24xx: remove unnecessary memset of s3c24xx_spi

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

>From 385a9c8fccc0308dbd8182c57b29a95e01e29688 Mon Sep 17 00:00:00 2001
From: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 30 Jun 2015 21:03:58 +0300
Subject: [PATCH] spi/s3c24xx: remove unnecessary memset of s3c24xx_spi

Memory for this struct is allocated by spi_alloc_master() using
kzalloc() so it doesn't need to be set to 0 one more time.

Signed-off-by: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index f747ca2..f36bc32 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -501,7 +501,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	}
 
 	hw = spi_master_get_devdata(master);
-	memset(hw, 0, sizeof(struct s3c24xx_spi));
 
 	hw->master = master;
 	hw->pdata = pdata = dev_get_platdata(&pdev->dev);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
