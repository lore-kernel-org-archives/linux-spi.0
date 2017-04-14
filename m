From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 2/2] spi: atmel: add deepest PM support to SAMA5D2
Date: Fri, 14 Apr 2017 10:22:43 +0200
Message-ID: <20170414082243.23002-2-quentin.schulz@free-electrons.com>
References: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@free-electrons.com,
        thomas.petazzoni@free-electrons.com
To: nicolas.ferre@microchip.com, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
SoC's SPI controller.

When resuming from deepest state, it is required to restore MR register
as the registers are lost since VDD core has been shut down when
entering deepest state on the SAMA5D2.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
  - fix commit log explanation on why restoring the registers is required
  after resuming from deepest state,

 drivers/spi/spi-atmel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 247d920..1eb83c9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
 static int atmel_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_master_get_devdata(master);
 	int ret;
 
+	ret = clk_prepare_enable(as->clk);
+	if (ret)
+		return ret;
+
+	atmel_spi_init(as);
+
+	clk_disable_unprepare(as->clk);
+
 	if (!pm_runtime_suspended(dev)) {
 		ret = atmel_spi_runtime_resume(dev);
 		if (ret)
-- 
2.9.3
