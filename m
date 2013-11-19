From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 2/2] spi/qspi: Fix qspi remove path.
Date: Tue, 19 Nov 2013 18:37:16 +0530
Message-ID: <1384866436-11542-3-git-send-email-sourav.poddar@ti.com>
References: <1384866436-11542-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384866436-11542-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is a bug in qspi removal path, as a result of which
qspi cannot be removed when used as a module. The patch
solves the bug and qspi can be removed cleanly.

The bugs fixed are:
-pm_runtime used around register access.
- pm_runtime_disable need to be done before removal.
- spi_unregister_master need to be called to unregister
   the spi device.
Tested on DRA7 board.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index b6ab396..033ef8d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -517,10 +517,26 @@ free_master:
 
 static int ti_qspi_remove(struct platform_device *pdev)
 {
-	struct	ti_qspi *qspi = platform_get_drvdata(pdev);
+	struct spi_master *master;
+	struct ti_qspi *qspi;
+	int ret;
+
+	master = platform_get_drvdata(pdev);
+	qspi = spi_master_get_devdata(master);
+
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0) {
+		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
 
 	ti_qspi_write(qspi, QSPI_WC_INT_DISABLE, QSPI_INTR_ENABLE_CLEAR_REG);
 
+	pm_runtime_put(qspi->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	spi_unregister_master(master);
+
 	return 0;
 }
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
