From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 23/27] spi: ti-qspi: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:13 +0530
Message-ID: <1411575342-31048-24-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/spi/spi-ti-qspi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6c211d1..3a57173 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -182,10 +182,9 @@ static int ti_qspi_setup(struct spi_device *spi)
 	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
 	ctx_reg->clkctrl = clk_mask;
 
-	pm_runtime_mark_last_busy(qspi->dev);
-	ret = pm_runtime_put_autosuspend(qspi->dev);
+	pm_runtime_last_busy_and_autosuspend(qspi->dev);
 	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
+		dev_err(qspi->dev, "pm_runtime_last_busy_and_autosuspend() failed\n");
 		return ret;
 	}
 
-- 
1.7.0.4
