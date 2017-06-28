From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: Fix kfree() NULL pointer error." to the spi tree
Date: Wed, 28 Jun 2017 20:24:46 +0100
Message-ID: <E1dQIZy-0004Xa-UJ@finisterre>
References: <36969f0624050d0ca6262e79bf4935698d063d84.1497950982.git.arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36969f0624050d0ca6262e79bf4935698d063d84.1497950982.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: Fix kfree() NULL pointer error.

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

>From 704c3098e4c55a409eaf5ec89cee1bccc8d44f4c Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 20 Jun 2017 15:00:53 +0530
Subject: [PATCH] spi: loopback-test: Fix kfree() NULL pointer error.

Here, rx/tx allocation can fail. So avoid kvfree call
with NULL pointer.

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 514997a143dc..3459965004f8 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -1021,10 +1021,9 @@ int spi_test_run_tests(struct spi_device *spi,
 		rx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
 	else
 		rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
-	if (!rx) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!rx)
+		return -ENOMEM;
+
 
 	if (use_vmalloc)
 		tx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
@@ -1032,7 +1031,7 @@ int spi_test_run_tests(struct spi_device *spi,
 		tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!tx) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_tx;
 	}
 
 	/* now run the individual tests in the table */
@@ -1057,8 +1056,9 @@ int spi_test_run_tests(struct spi_device *spi,
 	}
 
 out:
-	kvfree(rx);
 	kvfree(tx);
+err_tx:
+	kvfree(rx);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_test_run_tests);
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
