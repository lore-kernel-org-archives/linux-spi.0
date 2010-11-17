From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 10/49] spi: davinci: simplify prescalar calculation
Date: Wed, 17 Nov 2010 16:13:42 +0530
Message-ID: <1289990661-30126-11-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-10-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Simplify pre-scalar calculation and move it into a seprate
function.

Refuse to correct invalid pre-scalar values silently as this
might lead to unexpected bugs and lower performance. Instead
an error will force users to dig into the root-cause of the
issue.

While at it, remove some device specific checks on the maximum
SPI frequency. As the driver supports the SPI interface
implemented on various devices, it should only take care of core
SPI limitations and leave the device specific handling to platform
code.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   53 ++++++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index d5d7014..17269ad 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -53,6 +53,7 @@
 #define SPIFMT_WDELAY_MASK	0x3f000000u
 #define SPIFMT_WDELAY_SHIFT	24
 #define SPIFMT_CHARLEN_MASK	0x0000001Fu
+#define SPIFMT_PRESCALE_SHIFT	8
 
 
 /* SPIPC0 */
@@ -267,6 +268,29 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 }
 
 /**
+ * davinci_spi_get_prescale - Calculates the correct prescale value
+ * @maxspeed_hz: the maximum rate the SPI clock can run at
+ *
+ * This function calculates the prescale value that generates a clock rate
+ * less than or equal to the specified maximum.
+ *
+ * Returns: calculated prescale - 1 for easy programming into SPI registers
+ * or negative error number if valid prescalar cannot be updated.
+ */
+static inline int davinci_spi_get_prescale(struct davinci_spi *davinci_spi,
+							u32 max_speed_hz)
+{
+	int ret;
+
+	ret = DIV_ROUND_UP(clk_get_rate(davinci_spi->clk), max_speed_hz);
+
+	if (ret < 3 || ret > 256)
+		return -EINVAL;
+
+	return ret - 1;
+}
+
+/**
  * davinci_spi_setup_transfer - This functions will determine transfer method
  * @spi: spi device on which data transfer to be done
  * @t: spi transfer in which transfer info is filled
@@ -281,7 +305,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 	struct davinci_spi *davinci_spi;
 	u8 bits_per_word = 0;
-	u32 hz = 0, prescale = 0, clkspeed;
+	u32 hz = 0, prescale = 0;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 
@@ -312,21 +336,18 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	if (!hz)
 		hz = spi->max_speed_hz;
 
+	prescale = davinci_spi_get_prescale(davinci_spi, hz);
+	if (prescale < 0)
+		return prescale;
+
 	clear_fmt_bits(davinci_spi->base, SPIFMT_CHARLEN_MASK,
 			spi->chip_select);
 	set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
 			spi->chip_select);
 
-	clkspeed = clk_get_rate(davinci_spi->clk);
-	if (hz > clkspeed / 2)
-		prescale = 1 << 8;
-	if (hz < clkspeed / 256)
-		prescale = 255 << 8;
-	if (!prescale)
-		prescale = ((clkspeed / hz - 1) << 8) & 0x0000ff00;
-
 	clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_select);
-	set_fmt_bits(davinci_spi->base, prescale, spi->chip_select);
+	set_fmt_bits(davinci_spi->base,
+			prescale << SPIFMT_PRESCALE_SHIFT, spi->chip_select);
 
 	return 0;
 }
@@ -413,10 +434,8 @@ static int davinci_spi_setup(struct spi_device *spi)
 	int retval;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
-	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	sdev = davinci_spi->bitbang.master->dev.parent;
 
 	/* if bits per word length is zero then set it default 8 */
 	if (!spi->bits_per_word)
@@ -436,16 +455,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 	}
 
 	/*
-	 * SPI in DaVinci and DA8xx operate between
-	 * 600 KHz and 50 MHz
-	 */
-	if (spi->max_speed_hz < 600000 || spi->max_speed_hz > 50000000) {
-		dev_dbg(sdev, "Operating frequency is not in acceptable "
-				"range\n");
-		return -EINVAL;
-	}
-
-	/*
 	 * Set up SPIFMTn register, unique to this chipselect.
 	 *
 	 * NOTE: we could do all of these with one write.  Also, some
-- 
1.7.3.2
