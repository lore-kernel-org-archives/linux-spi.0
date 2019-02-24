From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 3/3] spi: bcm2835: add module parameter to configure minimum
 length for dma
Date: Sun, 24 Feb 2019 16:23:11 +0000
Message-ID: <20190224162311.23899-3-kernel@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224162311.23899-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Allow setting the length of the transfer at which dma is used by
setting a module parameter.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index dcf922ca2603..ef4b3468a97d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -44,6 +45,39 @@ module_param(polling_limit_us, uint, 0664);
 MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");

+/* define dma min number of bytes to use in dma mode with value validation */
+static int dma_min_bytes_limit_set(const char *val,
+				   const struct kernel_param *kp)
+{
+	unsigned int v;
+
+	if (kstrtouint(val, 10, &v))
+		return -EINVAL;
+	/* value needs to be a multiple of 4 */
+	if (v % 4) {
+		pr_err("dma_min_bytes_limit needs to be a multiple of 4\n");
+		return -EINVAL;
+	}
+	/* value needs to be at least 6 - so actually 8 - rational below */
+	if (v < 6) {
+		pr_err("dma_min_bytes_limit needs to be at least 8\n");
+		return -EINVAL;
+	}
+
+	return param_set_uint(val, kp);
+}
+
+static const struct kernel_param_ops dma_min_bytes_limit_ops = {
+	.set	= dma_min_bytes_limit_set,
+	.get	= param_get_int,
+};
+
+unsigned int dma_min_bytes_limit = 96;
+module_param_cb(dma_min_bytes_limit, &dma_min_bytes_limit_ops,
+		&dma_min_bytes_limit, 0664);
+MODULE_PARM_DESC(dma_min_bytes_limit,
+		 "minimum number of bytes to run a transfer in dma mode\n");
+
 /* SPI register offsets */
 #define BCM2835_SPI_CS			0x00
 #define BCM2835_SPI_FIFO		0x04
@@ -80,7 +114,6 @@ MODULE_PARM_DESC(polling_limit_us,

 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)

@@ -447,7 +480,8 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
  * if the length of the first is *exactly* 1.
  *
  * At most 6 bytes are written and at most 3 bytes read.  Do we know the
- * transfer has this many bytes?  Yes, see BCM2835_SPI_DMA_MIN_LENGTH.
+ * transfer has this many bytes?  Yes, see validation in
+ * dma_min_bytes_limit_set.
  *
  * The FIFO is normally accessed with 8-bit width by the CPU and 32-bit width
  * by the DMA engine.  Toggling the DMA Enable flag in the CS register switches
@@ -690,7 +724,7 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 				struct spi_transfer *tfr)
 {
 	/* we start DMA efforts only on bigger transfers */
-	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
+	if (tfr->len < dma_min_bytes_limit)
 		return false;

 	/* BCM2835_SPI_DLEN has defined a max transfer size as
--
2.11.0
