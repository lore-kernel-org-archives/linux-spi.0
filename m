From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/3] spi: spi-sh-msiof: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:46 +0200
Message-ID: <20181021200048.2114-3-wsa+renesas@sang-engineering.com>
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

 drivers/spi/spi-sh-msiof.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8670635b66fe..184b137bf3e9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,16 +1426,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int sh_msiof_spi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_suspend(p->master);
 }
 
 static int sh_msiof_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_resume(p->master);
 }
-- 
2.19.0
