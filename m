From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data
Date: Wed,  8 Jan 2020 13:40:32 -0800
Message-ID: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currrently the memory for the clk_bulk_data of the QSPI controller
is allocated with spi_alloc_master(). The bulk data pointer is passed
to devm_clk_bulk_get() which saves it in clk_bulk_devres->clks. When
the device is removed later devm_clk_bulk_release() is called and
uses the bulk data referenced by the pointer to release the clocks.
For this driver this results in accessing memory that has already
been freed, since the memory allocated with spi_alloc_master() is
released by spi_controller_release(), which is called before the
managed resources are released.

Use device managed memory for the clock bulk data to fix the issue
described above.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 250fd60e167821..3c4f83bf7084c8 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -137,7 +137,7 @@ enum qspi_clocks {
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
-	struct clk_bulk_data clks[QSPI_NUM_CLKS];
+	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
 	/* Lock to protect xfer and IRQ accessed registers */
 	spinlock_t lock;
@@ -445,6 +445,13 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 	}
 
+	ctrl->clks = devm_kcalloc(dev, QSPI_NUM_CLKS,
+				  sizeof(*ctrl->clks), GFP_KERNEL);
+	if (!ctrl->clks) {
+		ret = -ENOMEM;
+		goto exit_probe_master_put;
+	}
+
 	ctrl->clks[QSPI_CLK_CORE].id = "core";
 	ctrl->clks[QSPI_CLK_IFACE].id = "iface";
 	ret = devm_clk_bulk_get(dev, QSPI_NUM_CLKS, ctrl->clks);
-- 
2.25.0.rc1.283.g88dfdc4193-goog
