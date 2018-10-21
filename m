From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/3] spi: spi-zynqmp-gqspi: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:47 +0200
Message-ID: <20181021200048.2114-4-wsa+renesas@sang-engineering.com>
References: <20181021200048.2114-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

 drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index cc4d31033494..9f83e1b17aa1 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -960,8 +960,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 
 	clk_disable(xqspi->refclk);
@@ -980,8 +979,7 @@ static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 	int ret;
 
-- 
2.19.0
