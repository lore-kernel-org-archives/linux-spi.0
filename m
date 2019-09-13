From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 14/15] spi: tegra114: change format for `spi_set_cs_timing()` function
Date: Fri, 13 Sep 2019 14:45:49 +0300
Message-ID: <20190913114550.956-15-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The initial version of `spi_set_cs_timing()` was implemented with
consideration only for clock-cycles as delay.

For cases like `CS setup` time, it's sometimes needed that micro-seconds
(or nano-seconds) are required, or sometimes even longer delays, for cases
where the device needs a little longer to start transferring that after CS
is asserted.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++++++--
 drivers/spi/spi.c          | 16 ++++++++++------
 include/linux/spi/spi.h    |  9 ++++++---
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5ac2ceb234fc..d8db4af08fff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,15 +723,31 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
-static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
-				       u8 hold_dly, u8 inactive_dly)
+static int tegra_spi_set_hw_cs_timing(struct spi_device *spi,
+				      struct spi_delay *setup,
+				      struct spi_delay *hold,
+				      struct spi_delay *inactive)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	u8 setup_dly, hold_dly, inactive_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
+	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive && inactive != SPI_DELAY_UNIT_SCK)) {
+		dev_err(&spi->dev,
+			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
+			SPI_DELAY_UNIT_SCK);
+		return -EINVAL;
+	}
+
+	setup_dly = setup ? setup->value : 0;
+	hold_dly = hold ? hold->value : 0;
+	inactive_dly = inactive ? inactive->value : 0;
+
 	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
 	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
@@ -758,6 +774,8 @@ static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
 		tspi->spi_cs_timing2 = spi_cs_timing;
 		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
 	}
+
+	return 0;
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c55d55acbbb0..54d00c0a26d2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3147,15 +3147,19 @@ EXPORT_SYMBOL_GPL(spi_setup);
 /**
  * spi_set_cs_timing - configure CS setup, hold, and inactive delays
  * @spi: the device that requires specific CS timing configuration
- * @setup: CS setup time in terms of clock count
- * @hold: CS hold time in terms of clock count
- * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ * @setup: CS setup time specified via @spi_delay
+ * @hold: CS hold time specified via @spi_delay
+ * @inactive: CS inactive delay between transfers specified via @spi_delay
+ *
+ * Return: zero on success, else a negative error code.
  */
-void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
-		       u8 inactive_dly)
+int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
+		      struct spi_delay *hold, struct spi_delay *inactive)
 {
 	if (spi->controller->set_cs_timing)
-		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+		return spi->controller->set_cs_timing(spi, setup, hold,
+						      inactive);
+	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c7f90a0129be..292e752ce34a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -517,8 +517,8 @@ struct spi_controller {
 	 * to configure specific CS timing through spi_set_cs_timing() after
 	 * spi_setup().
 	 */
-	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
-			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+	int (*set_cs_timing)(struct spi_device *spi, struct spi_delay *setup,
+			     struct spi_delay *hold, struct spi_delay *inactive);
 
 	/* bidirectional bulk transfers
 	 *
@@ -1007,7 +1007,10 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
-extern void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold, u8 inactive_dly);
+extern int spi_set_cs_timing(struct spi_device *spi,
+			     struct spi_delay *setup,
+			     struct spi_delay *hold,
+			     struct spi_delay *inactive);
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-- 
2.20.1
