From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] spi: cadence: Add support for context loss
Date: Tue,  8 Aug 2017 11:00:03 +0200
Message-ID: <41f50cff7fd229448eb725f9d8ee97ec497457b2.1502182800.git.michal.simek@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Context could be lost across the suspend and resume.
Reinit the driver to tide over.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-cadence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5e02f9b91688..5c9516ae4942 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -704,7 +704,9 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
+	cdns_spi_init_hw(xspi);
 	return spi_master_resume(master);
 }
 
-- 
1.9.1
