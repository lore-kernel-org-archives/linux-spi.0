From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 01/11] net: dsa: sja1105: Add a debugging GPIO for monitoring SPI latency
Date: Fri, 16 Aug 2019 03:44:39 +0300
Message-ID: <20190816004449.10100-2-olteanv@gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816004449.10100-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I am using this to monitor the gettimex64 callback jitter, i.e. the
time it takes for the SPI controller to retrieve the PTP time from the
switch, and therefore the uncertainty in the time that has just been
read.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  4 ++++
 drivers/net/dsa/sja1105/sja1105_main.c | 11 +++++++++++
 drivers/net/dsa/sja1105/sja1105_ptp.c  |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 3dbfe41b370e..e6371b2c2df1 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -89,6 +89,7 @@ struct sja1105_private {
 	bool rgmii_tx_delay[SJA1105_NUM_PORTS];
 	const struct sja1105_info *info;
 	struct gpio_desc *reset_gpio;
+	struct gpio_desc *debug_gpio;
 	struct spi_device *spidev;
 	struct dsa_switch *ds;
 	struct sja1105_port ports[SJA1105_NUM_PORTS];
@@ -126,6 +127,9 @@ typedef enum {
 	SPI_WRITE = 1,
 } sja1105_spi_rw_mode_t;
 
+/* From sja1105_main.c */
+void sja1105_debug_gpio(struct sja1105_private *priv, bool enabled);
+
 /* From sja1105_spi.c */
 int sja1105_spi_send_packed_buf(const struct sja1105_private *priv,
 				sja1105_spi_rw_mode_t rw, u64 reg_addr,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 17b917d1e6be..82bdc2da8f8f 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -23,6 +23,15 @@
 #include <linux/dsa/8021q.h>
 #include "sja1105.h"
 
+void sja1105_debug_gpio(struct sja1105_private *priv, bool enabled)
+{
+	if (IS_ERR(priv->debug_gpio)) {
+		dev_err(priv->ds->dev, "Bad debug GPIO!\n");
+		return;
+	}
+	gpiod_set_value_cansleep(priv->debug_gpio, enabled);
+}
+
 static void sja1105_hw_reset(struct gpio_desc *gpio, unsigned int pulse_len,
 			     unsigned int startup_delay)
 {
@@ -2142,6 +2151,8 @@ static int sja1105_probe(struct spi_device *spi)
 	else
 		sja1105_hw_reset(priv->reset_gpio, 1, 1);
 
+	priv->debug_gpio = devm_gpiod_get(dev, "debug", GPIOD_OUT_HIGH);
+
 	/* Populate our driver private structure (priv) based on
 	 * the device tree node that was probed (spi)
 	 */
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 90a595cc596d..51a0014369fc 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -353,8 +353,10 @@ static u64 sja1105_ptptsclk_read(const struct cyclecounter *cc)
 	u64 ptptsclk = 0;
 	int rc;
 
+	sja1105_debug_gpio(priv, 1);
 	rc = sja1105_spi_send_int(priv, SPI_READ, regs->ptptsclk,
 				  &ptptsclk, 8);
+	sja1105_debug_gpio(priv, 0);
 	if (rc < 0)
 		dev_err_ratelimited(priv->ds->dev,
 				    "failed to read ptp cycle counter: %d\n",
-- 
2.17.1
