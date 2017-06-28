From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 4/4] spi: Use Apple device properties in absence of ACPI
 resources
Date: Wed, 28 Jun 2017 19:20:19 +0200
Message-ID: <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas@wunner.de>
References: <cover.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1498636759.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reported-by: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
Changes v1 -> v2:
- Move IS_ENABLED() and dmi_match() conditionals into callee. (Mika)
- Allow acpi_spi_parse_apple_properties() to augment or override _CRS
  by calling it unconditionally rather than only if _CRS is empty.

 drivers/spi/spi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 89254a55eb2e..51b7bdf841e4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -21,6 +21,8 @@
 #include <linux/cache.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/dmi.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -1685,6 +1687,32 @@ static void of_register_spi_devices(struct spi_master *master) { }
 #endif
 
 #ifdef CONFIG_ACPI
+static void acpi_spi_parse_apple_properties(struct spi_device *spi)
+{
+	struct acpi_device *dev = ACPI_COMPANION(&spi->dev);
+	const union acpi_object *o;
+
+	if (!IS_ENABLED(CONFIG_X86) || !dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
+		return;
+
+	if (!acpi_dev_get_property(dev, "spiSclkPeriod", ACPI_TYPE_BUFFER, &o))
+		spi->max_speed_hz  = div64_u64(NSEC_PER_SEC,
+					       *(u64 *)o->buffer.pointer);
+
+	if (!acpi_dev_get_property(dev, "spiWordSize", ACPI_TYPE_BUFFER, &o))
+		spi->bits_per_word = *(u64 *)o->buffer.pointer;
+
+	if (!acpi_dev_get_property(dev, "spiBitOrder", ACPI_TYPE_BUFFER, &o) &&
+	    !*(u64 *)o->buffer.pointer)
+		spi->mode |= SPI_LSB_FIRST;
+	if (!acpi_dev_get_property(dev, "spiSPO", ACPI_TYPE_BUFFER, &o) &&
+	     *(u64 *)o->buffer.pointer)
+		spi->mode |= SPI_CPOL;
+	if (!acpi_dev_get_property(dev, "spiSPH", ACPI_TYPE_BUFFER, &o) &&
+	     *(u64 *)o->buffer.pointer)
+		spi->mode |= SPI_CPHA;
+}
+
 static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct spi_device *spi = data;
@@ -1758,6 +1786,8 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
 				     acpi_spi_add_resource, spi);
 	acpi_dev_free_resource_list(&resource_list);
 
+	acpi_spi_parse_apple_properties(spi);
+
 	if (ret < 0 || !spi->max_speed_hz) {
 		spi_dev_put(spi);
 		return AE_OK;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
