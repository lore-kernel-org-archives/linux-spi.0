From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] spi: mxic: simplify getting .driver_data
Date: Tue, 19 Mar 2019 17:36:37 +0100
Message-ID: <20190319163637.30949-1-wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/spi/spi-mxic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e41ae6ef0f8a..f48563c09b97 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -492,8 +492,7 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 
 	mxic_spi_clk_disable(mxic);
@@ -504,8 +503,7 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 	int ret;
 
-- 
2.11.0
