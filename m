From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 17/20] spi: add a method for configuring CS timing
Date: Thu, 4 Apr 2019 17:14:16 -0700
Message-ID: <1554423259-26056-17-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch creates set_cs_timing SPI master optional method for
SPI masters to implement configuring CS timing if applicable.

This patch also creates spi_cs_timing accessory for SPI clients to
use for requesting SPI master controllers to configure device requested
CS setup time, hold time and inactive delay.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 15 +++++++++++++++
 include/linux/spi/spi.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 97ce047a776b..0f92329e990f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2995,6 +2995,21 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
+/**
+ * spi_set_cs_timing - configure CS setup, hold, and inactive delays
+ * @spi: the device that requires specific CS timing configuration
+ * @setup: CS setup time in terms of clock count
+ * @hold: CS hold time in terms of clock count
+ * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ */
+void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
+		       u8 inactive_dly)
+{
+	if (spi->controller->set_cs_timing)
+		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+}
+EXPORT_SYMBOL_GPL(spi_set_cs_timing);
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d5c86b763f43..fc4d21b4c2e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -331,6 +331,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	must fail if an unrecognized or unsupported mode is requested.
  *	It's always safe to call this unless transfers are pending on
  *	the device whose settings are being modified.
+ * @set_cs_timing: optional hook for SPI devices to request SPI master
+ * controller for configuring specific CS setup time, hold time and inactive
+ * delay interms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
@@ -364,6 +367,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
+ *
  * @set_cs: set the logic level of the chip select line.  May be called
  *          from interrupt context.
  * @prepare_message: set up the controller to transfer a single message,
@@ -489,6 +493,17 @@ struct spi_controller {
 	 */
 	int			(*setup)(struct spi_device *spi);
 
+	/*
+	 * set_cs_timing() method is for SPI controllers that supports
+	 * configuring CS timing.
+	 *
+	 * This hook allows SPI client drivers to request SPI controllers
+	 * to configure specific CS timing through spi_set_cs_timing() after
+	 * spi_setup().
+	 */
+	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+
 	/* bidirectional bulk transfers
 	 *
 	 * + The transfer() method may not sleep; its main role is
-- 
2.7.4
