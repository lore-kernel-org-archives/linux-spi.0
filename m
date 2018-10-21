From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/3] spi: spi-rspi: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:45 +0200
Message-ID: <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
References: <20181021200048.2114-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200048.2114-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/spi/spi-rspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 55f8e55327b3..a4ef641b5227 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1347,16 +1347,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int rspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_suspend(rspi->master);
 }
 
 static int rspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_resume(rspi->master);
 }
-- 
2.19.0
