From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] spi: Make of_find_spi_device_by_node() available
Date: Thu, 23 Aug 2018 12:33:30 +0200
Message-ID: <20180823103332.32047-3-linus.walleij@linaro.org>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Andy Shevchenko <andy@infradead.org>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 dev@lists.96boards.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180823103332.32047-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This externalizes and exports the symbol
of_find_spi_device_by_node() from the SPI core akin to how
of_find_i2c_adapter_by_node() is already available. As we will
need this also for non-dynamic OF setups, we move it under a
CONFIG_OF check.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog RFC->v1:
- No changes
- Requesting an ACK from the SPI mainatiner so that this patch
  can be applied with the rest of the series.
---
 drivers/spi/spi.c       | 33 ++++++++++++++++++---------------
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..6a1085077317 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3314,27 +3314,14 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 
 /*-------------------------------------------------------------------------*/
 
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
-static int __spi_of_device_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-/* must call put_device() when done with returned spi_device device */
-static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
-{
-	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
-						__spi_of_device_match);
-	return dev ? to_spi_device(dev) : NULL;
-}
-
+#if IS_ENABLED(CONFIG_OF)
 static int __spi_of_controller_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
 
 /* the spi controllers are not using spi_bus, so we find it with another way */
-static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
 	struct device *dev;
 
@@ -3349,6 +3336,22 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
 	/* reference got in class_find_device */
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+#endif
+
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static int __spi_of_device_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+/* must call put_device() when done with returned spi_device device */
+static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+{
+	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
+						__spi_of_device_match);
+	return dev ? to_spi_device(dev) : NULL;
+}
 
 static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			 void *arg)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e05321..c2be93224bd1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -639,6 +639,10 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+#if IS_ENABLED(CONFIG_OF)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
+#endif
+
 extern struct spi_controller *spi_busnum_to_master(u16 busnum);
 
 /*
-- 
2.17.0
