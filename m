From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch/rfc 2/2] spi: spi_gpio impements
	TX-only/RX-only
Date: Thu, 2 Jul 2009 16:36:14 -0700
Message-ID: <200907021636.14343.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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

From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

There are some boards that cut corners on the SPI standard and omit one
of the two data wires (MOSI or MISO) when connecting simple chips which
don't need them.  This is distinct from SPI_3WIRE, which also has just
one data line but uses that for bidirectional transfers.

One example of such board is a NCP ARM S3C6410 based machine.

This patch adds support for such non-standard configuration in GPIO-based
SPI controller.  It has been tested in configuration without MISO pin.

[ dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: split SPI core bits, compile fix, use
gpio_is_valid instead of designated GPIO literals, make sure half-duplex
flag is set too; add comment about those HDX modes; error checks ]

Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_gpio.c       |   64 ++++++++++++++++++++++++++++++-----------
 include/linux/spi/spi_gpio.h |   10 +++---
 2 files changed, 54 insertions(+), 20 deletions(-)

--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -109,12 +109,16 @@ static inline void setsck(const struct s
 
 static inline void setmosi(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value(SPI_MOSI_GPIO, is_on);
+	if (gpio_is_valid(SPI_MOSI_GPIO))
+		gpio_set_value(SPI_MOSI_GPIO, is_on);
 }
 
 static inline int getmiso(const struct spi_device *spi)
 {
-	return !!gpio_get_value(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		return !!gpio_get_value(SPI_MISO_GPIO);
+	else
+		return 0;
 }
 
 #undef pdata
@@ -228,24 +232,44 @@ static int __init spi_gpio_alloc(unsigne
 			value = gpio_direction_input(pin);
 		else
 			value = gpio_direction_output(pin, 0);
+		if (value)
+			gpio_free(pin);
 	}
 	return value;
 }
 
 static int __init
-spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
+spi_gpio_request(struct spi_gpio_platform_data *pdata,
+		const char *label, u16 *res_flags)
 {
 	int value;
 
 	/* NOTE:  SPI_*_GPIO symbols may reference "pdata" */
 
-	value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
-	if (value)
-		goto done;
+	/*
+	 * This supports some half-duplex signal-minimized flavors of
+	 * SPI, omitting MOSI (for RX only) or MISO (for TX only).
+	 *
+	 * REVISIT it could also be made to support SPI_3WIRE, which
+	 * also uses one data pin ... for both directions, switching
+	 * from output to input as needed for each spi_transfer.
+	 */
+	if (gpio_is_valid(SPI_MOSI_GPIO)) {
+		value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
+		if (value)
+			goto done;
+	} else {
+		if (!gpio_is_valid(SPI_MISO_GPIO))
+			return -ENODEV;
+		*res_flags |= SPI_MASTER_HALF_DUPLEX | SPI_MASTER_NO_TX;
+	}
 
-	value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
-	if (value)
-		goto free_mosi;
+	if (gpio_is_valid(SPI_MISO_GPIO)) {
+		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
+		if (value)
+			goto free_mosi;
+	} else
+		*res_flags |= SPI_MASTER_HALF_DUPLEX | SPI_MASTER_NO_RX;
 
 	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
 	if (value)
@@ -254,9 +278,11 @@ spi_gpio_request(struct spi_gpio_platfor
 	goto done;
 
 free_miso:
-	gpio_free(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		gpio_free(SPI_MISO_GPIO);
 free_mosi:
-	gpio_free(SPI_MOSI_GPIO);
+	if (gpio_is_valid(SPI_MOSI_GPIO))
+		gpio_free(SPI_MOSI_GPIO);
 done:
 	return value;
 }
@@ -267,6 +293,7 @@ static int __init spi_gpio_probe(struct 
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	u16				master_flags = 0;
 
 	pdata = pdev->dev.platform_data;
 #ifdef GENERIC_BITBANG
@@ -274,7 +301,7 @@ static int __init spi_gpio_probe(struct 
 		return -ENODEV;
 #endif
 
-	status = spi_gpio_request(pdata, dev_name(&pdev->dev));
+	status = spi_gpio_request(pdata, dev_name(&pdev->dev), &master_flags);
 	if (status < 0)
 		return status;
 
@@ -290,6 +317,7 @@ static int __init spi_gpio_probe(struct 
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
+	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	master->num_chipselect = SPI_N_CHIPSEL;
 	master->setup = spi_gpio_setup;
@@ -308,8 +336,10 @@ static int __init spi_gpio_probe(struct 
 	if (status < 0) {
 		spi_master_put(spi_gpio->bitbang.master);
 gpio_free:
-		gpio_free(SPI_MISO_GPIO);
-		gpio_free(SPI_MOSI_GPIO);
+		if (gpio_is_valid(SPI_MISO_GPIO))
+			gpio_free(SPI_MISO_GPIO);
+		if (gpio_is_valid(SPI_MOSI_GPIO))
+			gpio_free(SPI_MOSI_GPIO);
 		gpio_free(SPI_SCK_GPIO);
 		spi_master_put(master);
 	}
@@ -332,8 +362,10 @@ static int __exit spi_gpio_remove(struct
 
 	platform_set_drvdata(pdev, NULL);
 
-	gpio_free(SPI_MISO_GPIO);
-	gpio_free(SPI_MOSI_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		gpio_free(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MOSI_GPIO))
+		gpio_free(SPI_MOSI_GPIO);
 	gpio_free(SPI_SCK_GPIO);
 
 	return status;
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -38,8 +38,10 @@
 /**
  * struct spi_gpio_platform_data - parameter for bitbanged SPI master
  * @sck: number of the GPIO used for clock output
- * @mosi: number of the GPIO used for Master Output, Slave In (MOSI) data
- * @miso: number of the GPIO used for Master Input, Slave Output (MISO) data
+ * @mosi: Number of the GPIO used for Master Output, Slave In (MOSI) data.
+ *	If master output is unavailable, an invalid GPIO number like -EINVAL.
+ * @miso: Number of the GPIO used for Master Input, Slave Output (MISO) data.
+ *	If master input is unavailable, an invalid GPIO number like -EINVAL.
  * @num_chipselect: how many slaves to allow
  *
  * All GPIO signals used with the SPI bus managed through this driver
@@ -57,8 +59,8 @@
  */
 struct spi_gpio_platform_data {
 	unsigned	sck;
-	unsigned	mosi;
-	unsigned	miso;
+	int		mosi;
+	int		miso;
 
 	u16		num_chipselect;
 };

------------------------------------------------------------------------------
