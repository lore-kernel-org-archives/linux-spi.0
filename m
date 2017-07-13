From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v3 6/6] spi: Use Apple device properties in absence of ACPI
 resources
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <c137d15be96c954f405bda5acaaf730cccc8e601.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1499983092.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
for SPI slaves, causing device initialization to fail.  Most of the
information that would normally be conveyed via _CRS is available
through ACPI device properties instead, so take advantage of them.

The meaning and appropriate usage of the device properties was reverse
engineered by Ronald Tschalär and carried over from these commits
authored by him:

https://github.com/cb22/macbook12-spi-driver/commit/9a416d699ef4
https://github.com/cb22/macbook12-spi-driver/commit/0c34936ed9a1

According to Ronald, the device properties have the following meaning:

spiSclkPeriod   /* period in ns */
spiWordSize     /* in number of bits */
spiBitOrder     /* 1 = MSB_FIRST, 0 = LSB_FIRST */
spiSPO          /* clock polarity: 0 = low, 1 = high */
spiSPH          /* clock phase: 0 = first, 1 = second */
spiCSDelay      /* delay between cs and receive on reads in 10 us */
resetA2RUsec    /* active-to-receive delay? */
resetRecUsec    /* receive delay? */

Cc: Federico Lorenzi <florenzi@gmail.com>
Reported-by: Leif Liddy <leif.liddy@gmail.com>
Tested-by: Ronald Tschalär <ronald@innovation.ch>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
- Check buffer length for extra safety.  Rename "o" to "obj",
  use 32 bit division to calculate max_speed_hz. (Andy)

 drivers/spi/spi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4fcbb0aa71d3..cce133057700 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1693,6 +1693,35 @@ static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
 
 #ifdef CONFIG_ACPI
+static void acpi_spi_parse_apple_properties(struct spi_device *spi)
+{
+	struct acpi_device *dev = ACPI_COMPANION(&spi->dev);
+	const union acpi_object *obj;
+
+	if (!is_apple_system)
+		return;
+
+	if (!acpi_dev_get_property(dev, "spiSclkPeriod", ACPI_TYPE_BUFFER, &obj)
+	    && obj->buffer.length >= 4)
+		spi->max_speed_hz  = NSEC_PER_SEC / *(u32 *)obj->buffer.pointer;
+
+	if (!acpi_dev_get_property(dev, "spiWordSize", ACPI_TYPE_BUFFER, &obj)
+	    && obj->buffer.length == 8)
+		spi->bits_per_word = *(u64 *)obj->buffer.pointer;
+
+	if (!acpi_dev_get_property(dev, "spiBitOrder", ACPI_TYPE_BUFFER, &obj)
+	    && obj->buffer.length == 8 && !*(u64 *)obj->buffer.pointer)
+		spi->mode |= SPI_LSB_FIRST;
+
+	if (!acpi_dev_get_property(dev, "spiSPO", ACPI_TYPE_BUFFER, &obj)
+	    && obj->buffer.length == 8 &&  *(u64 *)obj->buffer.pointer)
+		spi->mode |= SPI_CPOL;
+
+	if (!acpi_dev_get_property(dev, "spiSPH", ACPI_TYPE_BUFFER, &obj)
+	    && obj->buffer.length == 8 &&  *(u64 *)obj->buffer.pointer)
+		spi->mode |= SPI_CPHA;
+}
+
 static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct spi_device *spi = data;
@@ -1766,6 +1795,8 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 				     acpi_spi_add_resource, spi);
 	acpi_dev_free_resource_list(&resource_list);
 
+	acpi_spi_parse_apple_properties(spi);
+
 	if (ret < 0 || !spi->max_speed_hz) {
 		spi_dev_put(spi);
 		return AE_OK;
-- 
2.11.0

