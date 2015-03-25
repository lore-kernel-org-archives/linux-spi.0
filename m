From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as SPI-chip_select
Date: Wed, 25 Mar 2015 08:10:57 +0100
Message-ID: <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150320095247.GE2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

use cs-gpios for the spi bus master and standard gpio operation
instead of relying on the HW with just 2 chip_selects.

Tested with 2x mcp251x (can bus), fb_st7735 (TFT framebuffer device) 
and enc28j60 (ethernet) drivers.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---
 drivers/spi/spi-bcm2835.c |   65 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)


> On 20.03.2015, at 10:52, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Thu, Mar 19, 2015 at 11:05:13PM -0600, Stephen Warren wrote:
>> 
>> 
>> A changelog between v1 and v2 would be useful. I think this looks OK
>> though, so,
>> Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> 

Changelog:
  V1->V2: use gpio_is_valid
          added error for null GPIO in DT for any CS except 0 or 1.
          no patch for bcm2835 device tree to use new system

> Note that none of these patches appear to have been sent to me, Stephen
> has CCed me in as far as I can tell...
Resent patch below.


diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1dea40..5fbad64 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>

 /* SPI register offsets */
@@ -116,6 +117,16 @@ static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs, int len)
 	}
 }

+/* ideally spi_set_cs would be exported by spi-core */
+static inline void bcm2835_set_cs(struct spi_device *spi, bool enable)
+{
+	if (spi->mode & SPI_CS_HIGH)
+		enable = !enable;
+
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_set_value(spi->cs_gpio, !enable);
+}
+
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
@@ -207,12 +218,24 @@ static int bcm2835_spi_start_transfer(
 		cs |= BCM2835_SPI_CS_CPHA;

 	if (!(spi->mode & SPI_NO_CS)) {
-		if (spi->mode & SPI_CS_HIGH) {
-			cs |= BCM2835_SPI_CS_CSPOL;
-			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
-		}
+		if (gpio_is_valid(spi->cs_gpio)) {
+			bcm2835_set_cs(spi, 1);
+		} else {
+			/* Legacy mode using HW chip selects
+			 * note that there is a bug in this when there are
+			 * multiple devices on the bus with at least one
+			 * having SPI_CS_HIGH set - the other CS_CSPOLX get
+			 * reset to 0 when any other device starts a transfer
+			 * this is due to a shared register for the polarity
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
@@ -248,9 +271,12 @@ static int bcm2835_spi_finish_transfer(
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
@@ -290,15 +316,39 @@ static int bcm2835_spi_transfer_one(
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
+	/* do not care when in SPI_NO_CS mode */
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+
+	/* setting up CS right from the start */
+	if (gpio_is_valid(spi->cs_gpio)) {
+		bcm2835_set_cs(spi, 0);
+		return 0;
+	}
+
+	/* Legacy mode using HW chipselects */
+	if (spi->chip_select > 2) {
+		dev_err(&spi->dev,
+			"setup: only three native chip-selects are supported\n"
+			);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -318,6 +368,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->num_chipselect = 3;
 	master->transfer_one_message = bcm2835_spi_transfer_one;
+	master->setup = bcm2835_spi_setup;
 	master->dev.of_node = pdev->dev.of_node;

 	bs = spi_master_get_devdata(master);
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
