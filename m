From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "- filename      : spi-ti-qspi-improve---remove-callback.patch
Date: Fri, 30 Oct 2015 10:43:40 +0900
Message-ID: <E1ZryjE-0000Ct-GT@finisterre>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

- name          : spi: ti-qspi: improve ->remove() callback" to the spi tree
In-Reply-To:  <1446127050-5957-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>

The patch

   - filename      : spi-ti-qspi-improve---remove-callback.patch
- name          : spi: ti-qspi: improve ->remove() callback

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

>From e6b5140b706689a38aaeabd9de8fb3e1531cf9cb Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Date: Thu, 29 Oct 2015 08:57:30 -0500
Subject: [PATCH] spi: ti-qspi: improve ->remove() callback

there's no need to call pm_runtime_get_sync()
followed by pm_runtime_put(). We should, instead,
just call pm_runtime_put_sync() and pm_runtime_disable().

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 89cf0c8..432bcc3 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -555,16 +555,7 @@ free_master:
 
 static int ti_qspi_remove(struct platform_device *pdev)
 {
-	struct ti_qspi *qspi = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
-		return ret;
-	}
-
-	pm_runtime_put(qspi->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
