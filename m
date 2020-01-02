From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] spi: Add generic support for unused native cs with cs-gpios
Date: Thu,  2 Jan 2020 14:38:17 +0100
Message-ID: <20200102133822.29346-2-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some SPI master controllers always drive a native chip select when
performing a transfer.  Hence when using both native and GPIO chip
selects, at least one native chip select must be left unused, to be
driven when performing transfers with slave devices using GPIO chip
selects.

Currently, to find an unused native chip select, SPI controller drivers
need to parse and process cs-gpios theirselves.  This is not only
duplicated in each driver that needs it, but also duplicates part of the
work done later at SPI controller registration time.  Note that this
cannot be done after spi_register_controller() returns, as at that time,
slave devices may have been probed already.

Hence add generic support to the SPI subsystem for finding an unused
native chip select.  Optionally, this unused native chip select, and all
other in-use native chip selects, can be validated against the maximum
number of native chip selects available on the controller hardware.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps the validation is considered overkill ("DT is assumed to be
correct")?

 drivers/spi/spi.c       | 17 +++++++++++++++++
 include/linux/spi/spi.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dc453896327106a0..38b4c78df506c060 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2458,6 +2458,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 	int nb, i;
 	struct gpio_desc **cs;
 	struct device *dev = &ctlr->dev;
+	unsigned long native_cs_mask = 0;
+	unsigned int num_cs_gpios = 0;
 
 	nb = gpiod_count(dev, "cs");
 	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
@@ -2499,7 +2501,22 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 			if (!gpioname)
 				return -ENOMEM;
 			gpiod_set_consumer_name(cs[i], gpioname);
+			num_cs_gpios++;
+			continue;
+		}
+
+		if (ctlr->max_native_cs && i >= ctlr->max_native_cs) {
+			dev_err(dev, "Invalid native chip select %d\n", i);
+			return -EINVAL;
 		}
+		native_cs_mask |= BIT(i);
+	}
+
+	ctlr->unused_native_cs = ffz(native_cs_mask);
+	if (num_cs_gpios && ctlr->max_native_cs &&
+	    ctlr->unused_native_cs >= ctlr->max_native_cs) {
+		dev_err(dev, "No unused native chip select available\n");
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 3a67a7e45633cf9c..6d16ba01ff5a2e20 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -423,6 +423,12 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	GPIO descriptors rather than using global GPIO numbers grabbed by the
  *	driver. This will fill in @cs_gpiods and @cs_gpios should not be used,
  *	and SPI devices will have the cs_gpiod assigned rather than cs_gpio.
+ * @unused_native_cs: When cs_gpiods is used, spi_register_controller() will
+ *	fill in this field with the first unused native CS, to be used by SPI
+ *	controller drivers that need to drive a native CS when using GPIO CS.
+ * @max_native_cs: When cs_gpiods is used, and this field is filled in,
+ *	spi_register_controller() will validate all native CS (including the
+ *	unused native CS) against this value.
  * @statistics: statistics for the spi_controller
  * @dma_tx: DMA transmit channel
  * @dma_rx: DMA receive channel
@@ -624,6 +630,8 @@ struct spi_controller {
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
+	u8			unused_native_cs;
+	u8			max_native_cs;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
2.17.1
