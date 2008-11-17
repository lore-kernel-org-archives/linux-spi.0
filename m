From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc5] atmel_spi: clean up SPIv1
	quirk handling
Date: Mon, 17 Nov 2008 11:47:44 -0800
Message-ID: <200811171147.44411.david-b@pacbell.net>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Currently, we have a flag called "new_1" which is basically equivalent
to cpu_is_at91rm9200(). The latter is also called directly a few places.

Clean up this mess by introducing a atmel_spi_v2() function for
determining the controller version, and move all version dependent code
over to use it. This allows us to remove the new_1 flag.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c |   40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -30,13 +30,6 @@
  * The core SPI transfer engine just talks to a register bank to set up
  * DMA transfers; transfer queue progress is driven by IRQs.  The clock
  * framework provides the base clock, subdivided for each spi_device.
- *
- * Newer controllers, marked with "new_1" flag, have:
- *  - CR.LASTXFER
- *  - SPI_MR.DIV32 may become FDIV or must-be-zero (here: always zero)
- *  - SPI_SR.TXEMPTY, SPI_SR.NSSR (and corresponding irqs)
- *  - SPI_CSRx.CSAAT
- *  - SPI_CSRx.SBCR allows faster clocking
  */
 struct atmel_spi {
 	spinlock_t		lock;
@@ -45,7 +38,6 @@ struct atmel_spi {
 	int			irq;
 	struct clk		*clk;
 	struct platform_device	*pdev;
-	unsigned		new_1:1;
 	struct spi_device	*stay;
 
 	u8			stopping;
@@ -63,6 +55,23 @@ struct atmel_spi {
 #define INVALID_DMA_ADDRESS	0xffffffff
 
 /*
+ * Version 2 of the SPI controller has
+ *  - CR.LASTXFER
+ *  - SPI_MR.DIV32 may become FDIV or must-be-zero (here: always zero)
+ *  - SPI_SR.TXEMPTY, SPI_SR.NSSR (and corresponding irqs)
+ *  - SPI_CSRx.CSAAT
+ *  - SPI_CSRx.SBCR allows faster clocking
+ *
+ * We can determine the controller version by reading the VERSION
+ * register, but I haven't checked that it exists on all chips, and
+ * this is cheaper anyway.
+ */
+static bool atmel_spi_is_v2(void)
+{
+	return !cpu_is_at91rm9200();
+}
+
+/*
  * Earlier SPI controllers (e.g. on at91rm9200) have a design bug whereby
  * they assume that spi slave device state will not change on deselect, so
  * that automagic deselection is OK.  ("NPCSx rises if no data is to be
@@ -105,7 +114,7 @@ static void cs_activate(struct atmel_spi
 			gpio, active ? " (high)" : "",
 			mr);
 
-	if (!(cpu_is_at91rm9200() && spi->chip_select == 0))
+	if (atmel_spi_is_v2() || spi->chip_select != 0)
 		gpio_set_value(gpio, active);
 	spi_writel(as, MR, mr);
 }
@@ -129,7 +138,7 @@ static void cs_deactivate(struct atmel_s
 			gpio, active ? " (low)" : "",
 			mr);
 
-	if (!(cpu_is_at91rm9200() && spi->chip_select == 0))
+	if (atmel_spi_is_v2() || spi->chip_select != 0)
 		gpio_set_value(gpio, !active);
 }
 
@@ -536,19 +545,16 @@ static int atmel_spi_setup(struct spi_de
 	}
 
 	/* see notes above re chipselect */
-	if (cpu_is_at91rm9200()
+	if (!atmel_spi_is_v2()
 			&& spi->chip_select == 0
 			&& (spi->mode & SPI_CS_HIGH)) {
 		dev_dbg(&spi->dev, "setup: can't be active-high\n");
 		return -EINVAL;
 	}
 
-	/*
-	 * Pre-new_1 chips start out at half the peripheral
-	 * bus speed.
-	 */
+	/* v1 chips start out at half the peripheral bus speed. */
 	bus_hz = clk_get_rate(as->clk);
-	if (!as->new_1)
+	if (!atmel_spi_is_v2())
 		bus_hz /= 2;
 
 	if (spi->max_speed_hz) {
@@ -755,8 +761,6 @@ static int __init atmel_spi_probe(struct
 		goto out_free_buffer;
 	as->irq = irq;
 	as->clk = clk;
-	if (!cpu_is_at91rm9200())
-		as->new_1 = 1;
 
 	ret = request_irq(irq, atmel_spi_interrupt, 0,
 			pdev->dev.bus_id, master);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
