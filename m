From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] SPI: control CS via standard GPIO operations instead of
 SPI-HW
Date: Wed,  4 Mar 2015 16:40:03 +0000
Message-ID: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
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

Allow the cs-gpios property in DT to be used instead of the
fixed two chip-selects provided by the SPI-HW itself

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---

There is the question if we still need to support the chip_selects
provided by the hardware (plus the buggy CSPOL_HIGH support for those cases)
or if we could just make the cs-gpios a required setting for this driver.
Going with the GPIO only solution would clean up the code a bit.

 drivers/spi/spi-bcm2835.c |   53 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 419a782..128a152 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Chris Boot
  * Copyright (C) 2013 Stephen Warren
+ * Copyright (C) 2015 Martin Sperl
  *
  * This driver is inspired by:
  * spi-ath79.c, Copyright (C) 2009-2011 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
@@ -30,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 
 /* SPI register offsets */
@@ -116,6 +118,18 @@ static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs, int len)
 	}
 }
 
+/* ideally spi_set_cs would be exported by spi-core */
+static inline void bcm2835_set_cs(struct spi_device *spi, bool enable)
+{
+
+	if (spi->mode & SPI_CS_HIGH)
+		enable = !enable;
+
+	if (spi->cs_gpio >= 0)
+		gpio_set_value(spi->cs_gpio, !enable);
+
+}
+
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
@@ -205,12 +219,24 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 		cs |= BCM2835_SPI_CS_CPHA;
 
 	if (!(spi->mode & SPI_NO_CS)) {
-		if (spi->mode & SPI_CS_HIGH) {
-			cs |= BCM2835_SPI_CS_CSPOL;
-			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
-		}
+		if (spi->cs_gpio >= 0)
+			bcm2835_set_cs(spi, 1);
+		else {
+			/* do we need to support this ?
+			 * note that there is a bug in this when there are
+			 * multiple devices on the bus with at least one
+			 * having SPI_CS_HIGH set (the other CS_CSPOLX get
+			 * reset to 0 when any other device
+			 * starts a transfer
+			 */
+			if (spi->mode & SPI_CS_HIGH) {
+				cs |= BCM2835_SPI_CS_CSPOL;
+				cs |= BCM2835_SPI_CS_CSPOL0
+					<< spi->chip_select;
+			}
 
-		cs |= spi->chip_select;
+			cs |= spi->chip_select;
+		}
 	}
 
 	reinit_completion(&bs->done);
@@ -245,9 +271,12 @@ static int bcm2835_spi_finish_transfer(struct spi_device *spi,
 	if (tfr->delay_usecs)
 		udelay(tfr->delay_usecs);
 
-	if (cs_change)
+	if (cs_change) {
+		/* reset CS */
+		bcm2835_set_cs(spi, 0);
 		/* Clear TA flag */
 		bcm2835_wr(bs, BCM2835_SPI_CS, cs & ~BCM2835_SPI_CS_TA);
+	}
 
 	return 0;
 }
@@ -285,15 +314,24 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	}
 
 out:
-	/* Clear FIFOs, and disable the HW block */
+	/* Clear FIFOs, reset CS and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+	bcm2835_set_cs(spi, 0);
 	mesg->status = err;
 	spi_finalize_current_message(master);
 
 	return 0;
 }
 
+static int bcm2835_spi_setup(struct spi_device *spi)
+{
+	/* setting up CS right from the start */
+	bcm2835_set_cs(spi, 0);
+
+	return 0;
+}
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -313,6 +351,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->num_chipselect = 3;
 	master->transfer_one_message = bcm2835_spi_transfer_one;
+	master->setup = bcm2835_spi_setup;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
-- 
1.7.10.4
