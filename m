From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
	select gpio to simplify the common cases
Date: Mon, 8 Sep 2008 17:04:43 -0700
Message-ID: <200809081704.43404.david-b@pacbell.net>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<f17812d70809040403u4c33e376vd8b3a2c5f034081c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f17812d70809040403u4c33e376vd8b3a2c5f034081c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 04 September 2008, Eric Miao wrote:
> As Russell suggested, updated with gpio_is_valid().

He beat me to that comment.  ;)

I like, but that doesn't apply on top of the bugfix patch
which I just cc'd you on...

Related:

 - It's probably worth removing support for the SSFRM
   mechanism and requiring gpio_cs or (at least as a
   transitional scheme) the cs_control() thing.

   I suggest issuing a strong warning for all devices
   which assume the SSFRM mechanism (single device
   on the bus segment too) ... and maybe a weaker one
   if they use cs_control, saying "use gpio_cs".

 - Remove the gpio_cs_inverted thing ... that's exactly
   what SPI_CS_HIGH is there to handle (in spi->mode).

The SSFRM issue is, briefly, that it forces deselect
of the chip between transfer segments even when the
driver doesn't want that.  If it's not disabled, the
transfer() routine needs integrity checks to make
sure it rejects all messages that don't expect that
deselection (unless cs_control/gpio_cs is used for
that particular spi_device).

The cs_control issue is more just simplification:  as
I recall, all users are just wrapping GPIOS, and giving
up potential SPI_CS_HIGH support while doing it.

- Dave


============
From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Most SPI peripherals use GPIOs as their chip select, introduce .gpio_cs
for this, to avoid 

Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h |    1 +
 drivers/spi/pxa2xx_spi.c                    |   92 ++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
b/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
index 2206cb6..b87cecd 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
+++ b/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
@@ -38,6 +38,7 @@ struct pxa2xx_spi_chip {
 	u8 dma_burst_size;
 	u32 timeout;
 	u8 enable_loopback;
+	int gpio_cs;
 	void (*cs_control)(u32 command);
 };

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 34c7c98..98d2338 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -28,6 +28,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -164,6 +165,8 @@ struct chip_data {
 	u8 enable_dma;
 	u8 bits_per_word;
 	u32 speed_hz;
+	int gpio_cs;
+	unsigned gpio_cs_inverted : 1;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 	void (*cs_control)(u32 command);
@@ -171,6 +174,32 @@ struct chip_data {

 static void pump_messages(struct work_struct *work);

+static void cs_assert(struct driver_data *drv_data)
+{
+	struct chip_data *chip = drv_data->cur_chip;
+
+	if (chip->cs_control) {
+		chip->cs_control(PXA2XX_CS_ASSERT);
+		return;
+	}
+
+	if (gpio_is_valid(chip->gpio_cs))
+		gpio_set_value(chip->gpio_cs, chip->gpio_cs_inverted);
+}
+
+static void cs_deassert(struct driver_data *drv_data)
+{
+	struct chip_data *chip = drv_data->cur_chip;
+
+	if (chip->cs_control) {
+		chip->cs_control(PXA2XX_CS_DEASSERT);
+		return;
+	}
+
+	if (gpio_is_valid(chip->gpio_cs))
+		gpio_set_value(chip->gpio_cs, !chip->gpio_cs_inverted);
+}
+
 static int flush(struct driver_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
@@ -187,10 +216,6 @@ static int flush(struct driver_data *drv_data)
 	return limit;
 }

-static void null_cs_control(u32 command)
-{
-}
-
 static int null_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
@@ -398,7 +423,6 @@ static void giveback(struct driver_data *drv_data)
 	msg = drv_data->cur_msg;
 	drv_data->cur_msg = NULL;
 	drv_data->cur_transfer = NULL;
-	drv_data->cur_chip = NULL;
 	queue_work(drv_data->workqueue, &drv_data->pump_messages);
 	spin_unlock_irqrestore(&drv_data->lock, flags);

@@ -407,7 +431,9 @@ static void giveback(struct driver_data *drv_data)
 					transfer_list);

 	if (!last_transfer->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+		cs_deassert(drv_data);
+
+	drv_data->cur_chip = NULL;

 	msg->state = NULL;
 	if (msg->complete)
@@ -493,7 +519,7 @@ static void dma_transfer_complete(struct driver_data *drv_data)
 	/* Release chip select if requested, transfer delays are
 	 * handled in pump_transfers */
 	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+		cs_deassert(drv_data);

 	/* Move to next transfer */
 	msg->state = next_transfer(drv_data);
@@ -605,7 +631,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	/* Release chip select if requested, transfer delays are
 	 * handled in pump_transfers */
 	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+		cs_deassert(drv_data);

 	/* Move to next transfer */
 	drv_data->cur_msg->state = next_transfer(drv_data);
@@ -868,7 +894,6 @@ static void pump_transfers(unsigned long data)
 	}
 	drv_data->n_bytes = chip->n_bytes;
 	drv_data->dma_width = chip->dma_width;
-	drv_data->cs_control = chip->cs_control;
 	drv_data->tx = (void *)transfer->tx_buf;
 	drv_data->tx_end = drv_data->tx + transfer->len;
 	drv_data->rx = transfer->rx_buf;
@@ -1020,7 +1045,7 @@ static void pump_transfers(unsigned long data)
 	 * this driver uses struct pxa2xx_spi_chip.cs_control to
 	 * specify a CS handling function, and it ignores most
 	 * struct spi_device.mode[s], including SPI_CS_HIGH */
-	drv_data->cs_control(PXA2XX_CS_ASSERT);
+	cs_assert(drv_data);

 	/* after chip select, release the data by enabling service
 	 * requests and interrupts, without changing any mode bits */
@@ -1098,6 +1123,43 @@ static int transfer(struct spi_device *spi, struct spi_message *msg)
 /* the spi->mode bits understood by this driver: */
 #define MODEBITS (SPI_CPOL | SPI_CPHA)

+static int setup_cs(struct spi_device *spi, struct chip_data *chip,
+		    struct pxa2xx_spi_chip *chip_info)
+{
+	int err = 0;
+	
+	if (chip_info == NULL)
+		return 0;
+
+	/* NOTE: setup() can be called multiple times, possibly with
+	 * different chip_info, previously requested GPIO shall be
+	 * released, stumped :(
+	 */
+	if (gpio_is_valid(chip->gpio_cs))
+		gpio_free(chip->gpio_cs);
+
+	if (chip_info->cs_control) {
+		chip->cs_control = chip_info->cs_control;
+		return 0;
+	}
+
+	if (gpio_is_valid(chip_info->gpio_cs)) {
+		err = gpio_request(chip_info->gpio_cs, "SPI_CS");
+		if (err) {
+			dev_err(&spi->dev, "failed to request CS GPIO%d\n",
+					chip_info->gpio_cs);
+			return err;
+		}
+
+		chip->gpio_cs = chip_info->gpio_cs;
+		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+
+		gpio_direction_output(chip->gpio_cs, !chip->gpio_cs_inverted);
+	}
+
+	return err;
+}
+
 static int setup(struct spi_device *spi)
 {
 	struct pxa2xx_spi_chip *chip_info = NULL;
@@ -1141,7 +1203,7 @@ static int setup(struct spi_device *spi)
 			return -ENOMEM;
 		}

-		chip->cs_control = null_cs_control;
+		chip->gpio_cs = -1;
 		chip->enable_dma = 0;
 		chip->timeout = 1000;
 		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
@@ -1156,9 +1218,6 @@ static int setup(struct spi_device *spi)
 	/* chip_info isn't always needed */
 	chip->cr1 = 0;
 	if (chip_info) {
-		if (chip_info->cs_control)
-			chip->cs_control = chip_info->cs_control;
-
 		chip->timeout = chip_info->timeout;

 		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
@@ -1238,13 +1297,16 @@ static int setup(struct spi_device *spi)

 	spi_set_ctldata(spi, chip);

-	return 0;
+	return setup_cs(spi, chip, chip_info);
 }

 static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);

+	if (gpio_is_valid(chip->gpio_cs))
+		gpio_free(chip->gpio_cs);
+
 	kfree(chip);
 }

-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
