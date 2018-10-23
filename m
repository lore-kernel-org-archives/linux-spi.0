From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
Date: Mon, 22 Oct 2018 18:07:07 -0700
Message-ID: <20181023010707.153647-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Address remaining comments from original driver patch series

* Move RD_FIFO_CFG to be ordered corretly
* Expand spinlock comment

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8163b40bb92..e0f061139c8f 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -90,6 +90,9 @@
 #define PIO_DATAOUT_1B		0x0020
 #define PIO_DATAOUT_4B		0x0024
 
+#define RD_FIFO_CFG		0x0028
+#define CONTINUOUS_MODE		BIT(0)
+
 #define RD_FIFO_STATUS	0x002c
 #define FIFO_EMPTY	BIT(11)
 #define WR_CNTS_MSK	0x7f0
@@ -99,9 +102,6 @@
 #define RDY_16BYTE	BIT(1)
 #define FIFO_RDY	BIT(0)
 
-#define RD_FIFO_CFG		0x0028
-#define CONTINUOUS_MODE		BIT(0)
-
 #define RD_FIFO_RESET		0x0030
 #define RESET_FIFO		BIT(0)
 
@@ -139,7 +139,7 @@ struct qcom_qspi {
 	struct device *dev;
 	struct clk_bulk_data clks[QSPI_NUM_CLKS];
 	struct qspi_xfer xfer;
-	/* Lock to protect data accessed by IRQs */
+	/* Lock to protect xfer and IRQ accessed registers */
 	spinlock_t lock;
 };
 
-- 
2.19.1.568.g152ad8e336-goog
