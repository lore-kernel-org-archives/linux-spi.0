From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi/qspi: Fix runtime resume path
Date: Fri, 20 Dec 2013 18:22:57 +0530
Message-ID: <1387543978-32309-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, <balbi-l0cyMroinI0@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Due to the following commit
commit 160a061301c7adf54c40696e7ceedc73f6b747dd
Author: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
Date:   Mon Nov 11 14:13:41 2013 +0800

    spi/qspi: set correct platform drvdata in ti_qspi_probe()

    The ti_qspi_remove() use the platform drvdata as a type of
    struct ti_qspi, we should pass correct platform drvdata to
    platform_set_drvdata() in ti_qspi_probe().

    Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
    Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

platform_set_drvdata was changed in  the probe, so we need to
correspondingly change deferencing of qspi in runtime resume
path. Else, this will lead to a NULL dereference pointer.

Based on v3.13-rc3

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4396bd4..06ee189 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -417,10 +417,8 @@ out:
 static int ti_qspi_runtime_resume(struct device *dev)
 {
 	struct ti_qspi      *qspi;
-	struct spi_master       *master;
 
-	master = dev_get_drvdata(dev);
-	qspi = spi_master_get_devdata(master);
+	qspi = dev_get_drvdata(dev);
 	ti_qspi_restore_ctx(qspi);
 
 	return 0;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
