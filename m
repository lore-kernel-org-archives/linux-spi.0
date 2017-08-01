From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v4 5/5] spi: Use Apple device properties in absence of ACPI
 resources
Date: Tue, 1 Aug 2017 14:10:41 +0200
Message-ID: <42d3fc7c3b18a80eec9a36bb3f71db6db2a20191.1501570421.git.lukas@wunner.de>
References: <cover.1501570421.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1501570421.git.lukas@wunner.de>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4fcbb0aa71d3..7d920ea19957 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -40,6 +40,7 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/platform_data/x86/apple.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -1693,6 +1694,35 @@ static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
 
 #ifdef CONFIG_ACPI
+static void acpi_spi_parse_apple_properties(struct spi_device *spi)
+{
+	struct acpi_device *dev = ACPI_COMPANION(&spi->dev);
+	const union acpi_object *obj;
+
+	if (!x86_apple_machine)
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
@@ -1766,6 +1796,8 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 				     acpi_spi_add_resource, spi);
 	acpi_dev_free_resource_list(&resource_list);
 
+	acpi_spi_parse_apple_properties(spi);
+
 	if (ret < 0 || !spi->max_speed_hz) {
 		spi_dev_put(spi);
 		return AE_OK;
-- 
2.11.0

