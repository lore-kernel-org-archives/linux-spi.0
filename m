From: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH -mm] max7301: check spi_setup() return
	code, general cleanup
Date: Thu, 12 Jun 2008 15:13:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806121504560.18017@axis700.grange>
References: <Pine.LNX.4.64.0806061625260.3338@axis700.grange>
	<200806120015.50953.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200806120015.50953.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Fix inaccuracies in comments, check spi_setup() return code, mask off high 
byte in max7301_read(). Thanks to David Brownell for the review.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---

On Thu, 12 Jun 2008, David Brownell wrote:

> Some comments about one routine; presumably more to follow:

Hopefully all points addressed.

Thanks
Guennadi

diff --git a/drivers/gpio/max7301.c b/drivers/gpio/max7301.c
index f35fac5..fc7cebc 100644
--- a/drivers/gpio/max7301.c
+++ b/drivers/gpio/max7301.c
@@ -71,7 +71,7 @@ struct max7301 {
  *
  * A write to the MAX7301 means one message with one transfer
  *
- * Returns 0 if successfull or a negative value on error
+ * Returns 0 if successful or a negative value on error
  */
 static int max7301_write(struct spi_device *spi, unsigned int reg, unsigned int val)
 {
@@ -84,9 +84,9 @@ static int max7301_write(struct spi_device *spi, unsigned int reg, unsigned int
  * @spi: The SPI device
  * @reg: Register offset
  *
- * A read from the MAX7301 means one message with two transfers
+ * A read from the MAX7301 means two messages with one transfer each
  *
- * Returns positive 8 bit value from device if successfull or a
+ * Returns positive 8 bit value from device if successful or a
  * negative value on error
  */
 static int max7301_read(struct spi_device *spi, unsigned int reg)
@@ -99,12 +99,13 @@ static int max7301_read(struct spi_device *spi, unsigned int reg)
 	if (ret)
 		return ret;
 	/*
-	 * FIXME: This read should write 0x0000 (=NOOP at MAX7301 side)
+	 * This relies on the fact, that a transfer with NULL tx_buf shifts out
+	 * zero bytes (=NOOP for MAX7301)
 	 */
 	ret = spi_read(spi, (u8 *)&word, sizeof(word));
 	if (ret)
 		return ret;
-	return word;
+	return word & 0xff;
 }
 
 static int max7301_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -224,7 +225,9 @@ static int __devinit max7301_probe(struct spi_device *spi)
 	 */
 	spi->bits_per_word = 16;
 
-	spi->master->setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 
 	ts = kzalloc(sizeof(struct max7301), GFP_KERNEL);
 	if (!ts)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
