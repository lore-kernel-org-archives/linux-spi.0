From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 7/7] spi: cadence: Return the error code for cdns_spi_suspend and cdns_spi_resume
Date: Tue, 5 Apr 2016 23:37:54 +0530
Message-ID: <1459879674-13012-7-git-send-email-shubhraj@xilinx.com>
References: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
	Shubhrajyoti Datta <shubhraj@xilinx.com>
To: <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Return the error code for cdns_spi_suspend and cdns_spi_resume.
Also fixes a comment where which claims that the error code is
returned.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/spi/spi-cadence.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index d0cdd18..07481e1 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -615,16 +615,14 @@ static int cdns_spi_remove(struct platform_device *pdev)
  * This function disables the SPI controller and
  * changes the driver state to "suspend"
  *
- * Return:	Always 0
+ * Return:	0 on success and error value on error
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
-	spi_master_suspend(master);
-
-	return 0;
+	return spi_master_suspend(master);
 }
 
 /**
@@ -640,9 +638,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
-	spi_master_resume(master);
-
-	return 0;
+	return spi_master_resume(master);
 }
 
 /**
-- 
1.7.1
