From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/dln2: simplify return flow for dln2_spi_transfer_setup and dln2_spi_enable
Date: Tue,  6 Jan 2015 15:23:40 +0200
Message-ID: <1420550620-12693-1-git-send-email-laurentiu.palcu@intel.com>
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This fixes the following kbuild test robot warnings:

>> drivers/spi/spi-dln2.c:124:1-4: WARNING: end returns can be simplified if negative or 0 value
>> drivers/spi/spi-dln2.c:656:1-4: WARNING: end returns can be simplified if negative or 0 value

Additionally, fix a comment after switching from CONFIG_PM_RUNTIME to
CONFIG_PM.

Reported-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-dln2.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index cede063..3b7d91d 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -103,7 +103,6 @@ struct dln2_spi {
  */
 static int dln2_spi_enable(struct dln2_spi *dln2, bool enable)
 {
-	int ret;
 	u16 cmd;
 	struct {
 		u8 port;
@@ -121,11 +120,7 @@ static int dln2_spi_enable(struct dln2_spi *dln2, bool enable)
 		cmd = DLN2_SPI_DISABLE;
 	}
 
-	ret = dln2_transfer_tx(dln2->pdev, cmd, &tx, len);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return dln2_transfer_tx(dln2->pdev, cmd, &tx, len);
 }
 
 /*
@@ -653,11 +648,7 @@ static int dln2_spi_transfer_setup(struct dln2_spi *dln2, u32 speed,
 		dln2->bpw = bpw;
 	}
 
-	ret = dln2_spi_enable(dln2, true);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return dln2_spi_enable(dln2, true);
 }
 
 static int dln2_spi_transfer_one(struct spi_master *master,
@@ -866,7 +857,7 @@ static int dln2_spi_runtime_resume(struct device *dev)
 
 	return  dln2_spi_enable(dln2, true);
 }
-#endif /* CONFIG_PM_RUNTIME */
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops dln2_spi_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(dln2_spi_suspend, dln2_spi_resume)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
