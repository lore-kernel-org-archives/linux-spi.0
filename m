From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22(+mm)] atmel_spi: don't always
	deselect chip between messages
Date: Mon, 9 Jul 2007 12:28:40 -0700
Message-ID: <200707091228.40295.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Update chipselect handling for atmel_spi:

  * Teach it how to leave chipselect active between messages; this
    helps various drivers work better.

  * Cope with at91rm0200 errata:  nCS0 can't be managed with GPIOs.
    The MR.PCS value is now updated whenever a chipselect changes.
    (This requires SPI pinmux init for that controller to change,
    and also testing on rm9200; doesn't break at91sam9 or avr32.)

  * Fix minor glitches:  spi_setup() must leave chipselects inactive,
    as must removal of the spi_device.

Also tweak diagnostic messaging to be a bit more useful.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Acked-by: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |  127 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 103 insertions(+), 24 deletions(-)

--- avr.orig/drivers/spi/atmel_spi.c	2007-06-07 14:17:46.000000000 -0700
+++ avr/drivers/spi/atmel_spi.c	2007-06-08 11:39:35.000000000 -0700
@@ -46,6 +46,7 @@ struct atmel_spi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	unsigned		new_1:1;
+	struct spi_device	*stay;
 
 	u8			stopping;
 	struct list_head	queue;
@@ -62,29 +63,62 @@ struct atmel_spi {
 /*
  * Earlier SPI controllers (e.g. on at91rm9200) have a design bug whereby
  * they assume that spi slave device state will not change on deselect, so
- * that automagic deselection is OK.  Not so!  Workaround uses nCSx pins
- * as GPIOs; or newer controllers have CSAAT and friends.
+ * that automagic deselection is OK.  ("NPCSx rises if no data is to be
+ * transmitted")  Not so!  Workaround uses nCSx pins as GPIOs; or newer
+ * controllers have CSAAT and friends.
  *
- * Since the CSAAT functionality is a bit weird on newer controllers
- * as well, we use GPIO to control nCSx pins on all controllers.
+ * Since the CSAAT functionality is a bit weird on newer controllers as
+ * well, we use GPIO to control nCSx pins on all controllers, updating
+ * MR.PCS to avoid confusing the controller.  Using GPIOs also lets us
+ * support active-high chipselects despite the controller's belief that
+ * only active-low devices/systems exists.
+ *
+ * However, at91rm9200 has a second erratum whereby nCS0 doesn't work
+ * right when driven with GPIO.  ("Mode Fault does not allow more than one
+ * Master on Chip Select 0.")  No workaround exists for that ... so for
+ * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
+ * and (c) will trigger that first erratum in some cases.
  */
 
-static inline void cs_activate(struct spi_device *spi)
+static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
 	unsigned gpio = (unsigned) spi->controller_data;
 	unsigned active = spi->mode & SPI_CS_HIGH;
+	u32 mr;
 
-	dev_dbg(&spi->dev, "activate %u%s\n", gpio, active ? " (high)" : "");
-	gpio_set_value(gpio, active);
+	mr = spi_readl(as, MR);
+	mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
+
+	dev_dbg(&spi->dev, "activate %u%s, mr %08x\n",
+			gpio, active ? " (high)" : "",
+			mr);
+
+	if (!(cpu_is_at91rm9200() && spi->chip_select == 0))
+		gpio_set_value(gpio, active);
+	spi_writel(as, MR, mr);
 }
 
-static inline void cs_deactivate(struct spi_device *spi)
+static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 {
 	unsigned gpio = (unsigned) spi->controller_data;
 	unsigned active = spi->mode & SPI_CS_HIGH;
+	u32 mr;
 
-	dev_dbg(&spi->dev, "DEactivate %u%s\n", gpio, active ? " (low)" : "");
-	gpio_set_value(gpio, !active);
+	/* only deactivate *this* device; sometimes transfers to
+	 * another device may be active when this routine is called.
+	 */
+	mr = spi_readl(as, MR);
+	if (~SPI_BFEXT(PCS, mr) & (1 << spi->chip_select)) {
+		mr = SPI_BFINS(PCS, 0xf, mr);
+		spi_writel(as, MR, mr);
+	}
+
+	dev_dbg(&spi->dev, "DEactivate %u%s, mr %08x\n",
+			gpio, active ? " (low)" : "",
+			mr);
+
+	if (!(cpu_is_at91rm9200() && spi->chip_select == 0))
+		gpio_set_value(gpio, !active);
 }
 
 /*
@@ -140,6 +174,7 @@ static void atmel_spi_next_xfer(struct s
 
 	/* REVISIT: when xfer->delay_usecs == 0, the PDC "next transfer"
 	 * mechanism might help avoid the IRQ latency between transfers
+	 * (and improve the nCS0 errata handling on at91rm9200 chips)
 	 *
 	 * We're also waiting for ENDRX before we start the next
 	 * transfer because we need to handle some difficult timing
@@ -169,17 +204,25 @@ static void atmel_spi_next_message(struc
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct spi_message	*msg;
-	u32			mr;
+	struct spi_device	*spi;
 
 	BUG_ON(as->current_transfer);
 
 	msg = list_entry(as->queue.next, struct spi_message, queue);
+	spi = msg->spi;
 
-	/* Select the chip */
-	mr = spi_readl(as, MR);
-	mr = SPI_BFINS(PCS, ~(1 << msg->spi->chip_select), mr);
-	spi_writel(as, MR, mr);
-	cs_activate(msg->spi);
+	dev_dbg(master->cdev.dev, "start message %p for %s\n",
+			msg, spi->dev.bus_id);
+
+	/* select chip if it's not still active */
+	if (as->stay) {
+		if (as->stay != spi) {
+			cs_deactivate(as, as->stay);
+			cs_activate(as, spi);
+		}
+		as->stay = NULL;
+	} else
+		cs_activate(as, spi);
 
 	atmel_spi_next_xfer(master, msg);
 }
@@ -232,9 +275,13 @@ static void atmel_spi_dma_unmap_xfer(str
 
 static void
 atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
-		   struct spi_message *msg, int status)
+		struct spi_message *msg, int status, int stay)
 {
-	cs_deactivate(msg->spi);
+	if (!stay || status < 0)
+		cs_deactivate(as, msg->spi);
+	else
+		as->stay = msg->spi;
+
 	list_del(&msg->queue);
 	msg->status = status;
 
@@ -324,7 +371,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 		/* Clear any overrun happening while cleaning up */
 		spi_readl(as, SR);
 
-		atmel_spi_msg_done(master, as, msg, -EIO);
+		atmel_spi_msg_done(master, as, msg, -EIO, 0);
 	} else if (pending & SPI_BIT(ENDRX)) {
 		ret = IRQ_HANDLED;
 
@@ -342,12 +389,13 @@ atmel_spi_interrupt(int irq, void *dev_i
 
 			if (msg->transfers.prev == &xfer->transfer_list) {
 				/* report completed message */
-				atmel_spi_msg_done(master, as, msg, 0);
+				atmel_spi_msg_done(master, as, msg, 0,
+						xfer->cs_change);
 			} else {
 				if (xfer->cs_change) {
-					cs_deactivate(msg->spi);
+					cs_deactivate(as, msg->spi);
 					udelay(1);
-					cs_activate(msg->spi);
+					cs_activate(as, msg->spi);
 				}
 
 				/*
@@ -409,6 +457,14 @@ static int atmel_spi_setup(struct spi_de
 		return -EINVAL;
 	}
 
+	/* see notes above re chipselect */
+	if (cpu_is_at91rm9200()
+			&& spi->chip_select == 0
+			&& (spi->mode & SPI_CS_HIGH)) {
+		dev_dbg(&spi->dev, "setup: can't be active-high\n");
+		return -EINVAL;
+	}
+
 	/* speed zero convention is used by some upper layers */
 	bus_hz = clk_get_rate(as->clk);
 	if (spi->max_speed_hz) {
@@ -445,6 +501,14 @@ static int atmel_spi_setup(struct spi_de
 			return ret;
 		spi->controller_state = (void *)npcs_pin;
 		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
+	} else {
+		unsigned long		flags;
+
+		spin_lock_irqsave(&as->lock, flags);
+		if (as->stay == spi)
+			as->stay = NULL;
+		cs_deactivate(as, spi);
+		spin_unlock_irqrestore(&as->lock, flags);
 	}
 
 	dev_dbg(&spi->dev,
@@ -501,6 +565,7 @@ static int atmel_spi_transfer(struct spi
 		}
 	}
 
+#ifdef VERBOSE
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		dev_dbg(controller,
 			"  xfer %p: len %u tx %p/%08x rx %p/%08x\n",
@@ -508,6 +573,7 @@ static int atmel_spi_transfer(struct spi
 			xfer->tx_buf, xfer->tx_dma,
 			xfer->rx_buf, xfer->rx_dma);
 	}
+#endif
 
 	msg->status = -EINPROGRESS;
 	msg->actual_length = 0;
@@ -523,8 +589,21 @@ static int atmel_spi_transfer(struct spi
 
 static void atmel_spi_cleanup(struct spi_device *spi)
 {
-	if (spi->controller_state)
-		gpio_free((unsigned int)spi->controller_data);
+	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
+	unsigned		gpio = (unsigned) spi->controller_data;
+	unsigned long		flags;
+
+	if (!spi->controller_state)
+		return;
+
+	spin_lock_irqsave(&as->lock, flags);
+	if (as->stay == spi) {
+		as->stay = NULL;
+		cs_deactivate(as, spi);
+	}
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	gpio_free(gpio);
 }
 
 /*-------------------------------------------------------------------------*/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
