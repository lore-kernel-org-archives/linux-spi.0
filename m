From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] spi_bitbang: move txrx utility
	functions to private header
Date: Thu, 6 May 2010 15:51:04 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636ECB528C@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

A number of files in drivers/spi fail checkincludes.pl due to the double
include of <linux/spi/spi_bitbang.h>.

The first include is needed to get the struct spi_bitbang definition and
the spi_bitbang_* function prototypes.

The second include happens after defining EXPAND_BITBANG_TXRX to get the
inlined bitbang_txrx_* utility functions.

The <linux/spi/spi_bitbang.h> header is also included by a number of other
spi drivers, as well as some arch/ code, in order to use struct spi_bitbang
and the associated functions.

To fix the double include, and remove any potential confusion about it, move
the inlined bitbang_txrx_* functions to a new private header in drivers/spi
and also remove the need to define EXPAND_BITBANG_TXRX.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

---

diff --git a/drivers/spi/spi_bitbang_txrx.h b/drivers/spi/spi_bitbang_txrx.h
new file mode 100644
index 0000000..fc033bb
--- /dev/null
+++ b/drivers/spi/spi_bitbang_txrx.h
@@ -0,0 +1,93 @@
+/*
+ * Mix this utility code with some glue code to get one of several types of
+ * simple SPI master driver.  Two do polled word-at-a-time I/O:
+ *
+ *   -	GPIO/parport bitbangers.  Provide chipselect() and txrx_word[](),
+ *	expanding the per-word routines from the inline templates below.
+ *
+ *   -	Drivers for controllers resembling bare shift registers.  Provide
+ *	chipselect() and txrx_word[](), with custom setup()/cleanup() methods
+ *	that use your controller's clock and chipselect registers.
+ *
+ * Some hardware works well with requests at spi_transfer scope:
+ *
+ *   -	Drivers leveraging smarter hardware, with fifos or DMA; or for half
+ *	duplex (MicroWire) controllers.  Provide chipselect() and txrx_bufs(),
+ *	and custom setup()/cleanup() methods.
+ */
+
+/*
+ * The code that knows what GPIO pins do what should have declared four
+ * functions, ideally as inlines, before including this header:
+ *
+ *  void setsck(struct spi_device *, int is_on);
+ *  void setmosi(struct spi_device *, int is_on);
+ *  int getmiso(struct spi_device *);
+ *  void spidelay(unsigned);
+ *
+ * setsck()'s is_on parameter is a zero/nonzero boolean.
+ *
+ * setmosi()'s is_on parameter is a zero/nonzero boolean.
+ *
+ * getmiso() is required to return 0 or 1 only. Any other value is invalid
+ * and will result in improper operation.
+ *
+ * A non-inlined routine would call bitbang_txrx_*() routines.  The
+ * main loop could easily compile down to a handful of instructions,
+ * especially if the delay is a NOP (to run at peak speed).
+ *
+ * Since this is software, the timings may not be exactly what your board's
+ * chips need ... there may be several reasons you'd need to tweak timings
+ * in these routines, not just make to make it faster or slower to match a
+ * particular CPU clock rate.
+ */
+
+static inline u32
+bitbang_txrx_be_cpha0(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on trailing edge */
+		setmosi(spi, word & (1 << 31));
+		spidelay(nsecs);	/* T(setup) */
+
+		setsck(spi, !cpol);
+		spidelay(nsecs);
+
+		/* sample MSB (from slave) on leading edge */
+		word <<= 1;
+		word |= getmiso(spi);
+		setsck(spi, cpol);
+	}
+	return word;
+}
+
+static inline u32
+bitbang_txrx_be_cpha1(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on leading edge */
+		setsck(spi, !cpol);
+		setmosi(spi, word & (1 << 31));
+		spidelay(nsecs); /* T(setup) */
+
+		setsck(spi, cpol);
+		spidelay(nsecs);
+
+		/* sample MSB (from slave) on trailing edge */
+		word <<= 1;
+		word |= getmiso(spi);
+	}
+	return word;
+}
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index c218486..8b52812 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -149,8 +149,7 @@ static void butterfly_chipselect(struct spi_device *spi, int value)
 #define	spidelay(X)	do{}while(0)
 //#define	spidelay	ndelay
 
-#define	EXPAND_BITBANG_TXRX
-#include <linux/spi/spi_bitbang.h>
+#include "spi_bitbang_txrx.h"
 
 static u32
 butterfly_txrx_word_mode0(struct spi_device *spi,
diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index 26bd03e..7edbd58 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -127,8 +127,7 @@ static inline int getmiso(const struct spi_device *spi)
  */
 #define spidelay(nsecs)	do {} while (0)
 
-#define	EXPAND_BITBANG_TXRX
-#include <linux/spi/spi_bitbang.h>
+#include "spi_bitbang_txrx.h"
 
 /*
  * These functions can leverage inline expansion of GPIO calls to shrink
diff --git a/drivers/spi/spi_lm70llp.c b/drivers/spi/spi_lm70llp.c
index 568c781..86fb7b5 100644
--- a/drivers/spi/spi_lm70llp.c
+++ b/drivers/spi/spi_lm70llp.c
@@ -174,8 +174,7 @@ static inline int getmiso(struct spi_device *s)
 }
 /*--------------------------------------------------------------------*/
 
-#define EXPAND_BITBANG_TXRX 1
-#include <linux/spi/spi_bitbang.h>
+#include "spi_bitbang_txrx.h"
 
 static void lm70_chipselect(struct spi_device *spi, int value)
 {
diff --git a/drivers/spi/spi_s3c24xx_gpio.c b/drivers/spi/spi_s3c24xx_gpio.c
index bbf9371..8979a75 100644
--- a/drivers/spi/spi_s3c24xx_gpio.c
+++ b/drivers/spi/spi_s3c24xx_gpio.c
@@ -58,8 +58,7 @@ static inline u32 getmiso(struct spi_device *dev)
 
 #define spidelay(x) ndelay(x)
 
-#define	EXPAND_BITBANG_TXRX
-#include <linux/spi/spi_bitbang.h>
+#include "spi_bitbang_txrx.h"
 
 
 static u32 s3c2410_spigpio_txrx_mode0(struct spi_device *spi,
diff --git a/drivers/spi/spi_sh_sci.c b/drivers/spi/spi_sh_sci.c
index a65c12f..a511be7 100644
--- a/drivers/spi/spi_sh_sci.c
+++ b/drivers/spi/spi_sh_sci.c
@@ -78,8 +78,7 @@ static inline u32 getmiso(struct spi_device *dev)
 
 #define spidelay(x) ndelay(x)
 
-#define EXPAND_BITBANG_TXRX
-#include <linux/spi/spi_bitbang.h>
+#include "spi_bitbang_txrx.h"
 
 static u32 sh_sci_spi_txrx_mode0(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 3274c50..f987a2b 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -1,24 +1,6 @@
 #ifndef	__SPI_BITBANG_H
 #define	__SPI_BITBANG_H
 
-/*
- * Mix this utility code with some glue code to get one of several types of
- * simple SPI master driver.  Two do polled word-at-a-time I/O:
- *
- *   -	GPIO/parport bitbangers.  Provide chipselect() and txrx_word[](),
- *	expanding the per-word routines from the inline templates below.
- *
- *   -	Drivers for controllers resembling bare shift registers.  Provide
- *	chipselect() and txrx_word[](), with custom setup()/cleanup() methods
- *	that use your controller's clock and chipselect registers.
- *
- * Some hardware works well with requests at spi_transfer scope:
- *
- *   -	Drivers leveraging smarter hardware, with fifos or DMA; or for half
- *	duplex (MicroWire) controllers.  Provide chipselect() and txrx_bufs(),
- *	and custom setup()/cleanup() methods.
- */
-
 #include <linux/workqueue.h>
 
 struct spi_bitbang {
@@ -68,86 +50,3 @@ extern int spi_bitbang_start(struct spi_bitbang *spi);
 extern int spi_bitbang_stop(struct spi_bitbang *spi);
 
 #endif	/* __SPI_BITBANG_H */
-
-/*-------------------------------------------------------------------------*/
-
-#ifdef	EXPAND_BITBANG_TXRX
-
-/*
- * The code that knows what GPIO pins do what should have declared four
- * functions, ideally as inlines, before #defining EXPAND_BITBANG_TXRX
- * and including this header:
- *
- *  void setsck(struct spi_device *, int is_on);
- *  void setmosi(struct spi_device *, int is_on);
- *  int getmiso(struct spi_device *);
- *  void spidelay(unsigned);
- *
- * setsck()'s is_on parameter is a zero/nonzero boolean.
- *
- * setmosi()'s is_on parameter is a zero/nonzero boolean.
- *
- * getmiso() is required to return 0 or 1 only. Any other value is invalid
- * and will result in improper operation.
- *
- * A non-inlined routine would call bitbang_txrx_*() routines.  The
- * main loop could easily compile down to a handful of instructions,
- * especially if the delay is a NOP (to run at peak speed).
- *
- * Since this is software, the timings may not be exactly what your board's
- * chips need ... there may be several reasons you'd need to tweak timings
- * in these routines, not just make to make it faster or slower to match a
- * particular CPU clock rate.
- */
-
-static inline u32
-bitbang_txrx_be_cpha0(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol,
-		u32 word, u8 bits)
-{
-	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
-
-	/* clock starts at inactive polarity */
-	for (word <<= (32 - bits); likely(bits); bits--) {
-
-		/* setup MSB (to slave) on trailing edge */
-		setmosi(spi, word & (1 << 31));
-		spidelay(nsecs);	/* T(setup) */
-
-		setsck(spi, !cpol);
-		spidelay(nsecs);
-
-		/* sample MSB (from slave) on leading edge */
-		word <<= 1;
-		word |= getmiso(spi);
-		setsck(spi, cpol);
-	}
-	return word;
-}
-
-static inline u32
-bitbang_txrx_be_cpha1(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol,
-		u32 word, u8 bits)
-{
-	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
-
-	/* clock starts at inactive polarity */
-	for (word <<= (32 - bits); likely(bits); bits--) {
-
-		/* setup MSB (to slave) on leading edge */
-		setsck(spi, !cpol);
-		setmosi(spi, word & (1 << 31));
-		spidelay(nsecs); /* T(setup) */
-
-		setsck(spi, cpol);
-		spidelay(nsecs);
-
-		/* sample MSB (from slave) on trailing edge */
-		word <<= 1;
-		word |= getmiso(spi);
-	}
-	return word;
-}
-
-#endif	/* EXPAND_BITBANG_TXRX */
------------------------------------------------------------------------------
