From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] drivers: gpio: bitbang: add support
 for SPI_MASTER_NO_{TX, RX} modes
Date: Fri, 18 Jun 2010 08:11:03 +0200
Message-ID: <1276841464-7984-2-git-send-email-m.szyprowski@samsung.com>
References: <1276841464-7984-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1276841464-7984-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds a new flags argument to bitbang_txrx_be_cpha0 and
bitbang_txrx_be_cpha1 transfer functions. This enables support for
SPI_MASTER_NO_{TX,RX} transfer modes. The change should have no impact
on speed of the existing drivers. bitbank_txrx_* functions are usually
inlined into the drivers. When the argument is equal to constant zero,
the optimizer would be able to eliminate the dead code (flags checks)
easily. Tested on ARM and GCC 4.4.x and in all cases the checks were
eliminated in the inlined function.

Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_bitbang_txrx.h |   16 ++++++++++------
 drivers/spi/spi_butterfly.c    |    2 +-
 drivers/spi/spi_gpio.c         |    8 ++++----
 drivers/spi/spi_lm70llp.c      |    2 +-
 drivers/spi/spi_s3c24xx_gpio.c |    8 ++++----
 drivers/spi/spi_sh_sci.c       |    8 ++++----
 6 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi_bitbang_txrx.h b/drivers/spi/spi_bitbang_txrx.h
index fc033bb..c16bf85 100644
--- a/drivers/spi/spi_bitbang_txrx.h
+++ b/drivers/spi/spi_bitbang_txrx.h
@@ -44,7 +44,7 @@
 
 static inline u32
 bitbang_txrx_be_cpha0(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol,
+		unsigned nsecs, unsigned cpol, unsigned flags,
 		u32 word, u8 bits)
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
@@ -53,7 +53,8 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0)
+			setmosi(spi, word & (1 << 31));
 		spidelay(nsecs);	/* T(setup) */
 
 		setsck(spi, !cpol);
@@ -61,7 +62,8 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 
 		/* sample MSB (from slave) on leading edge */
 		word <<= 1;
-		word |= getmiso(spi);
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi);
 		setsck(spi, cpol);
 	}
 	return word;
@@ -69,7 +71,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 
 static inline u32
 bitbang_txrx_be_cpha1(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol,
+		unsigned nsecs, unsigned cpol, unsigned flags,
 		u32 word, u8 bits)
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
@@ -79,7 +81,8 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0)
+			setmosi(spi, word & (1 << 31));
 		spidelay(nsecs); /* T(setup) */
 
 		setsck(spi, cpol);
@@ -87,7 +90,8 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* sample MSB (from slave) on trailing edge */
 		word <<= 1;
-		word |= getmiso(spi);
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi);
 	}
 	return word;
 }
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index 8b52812..0d4ceba 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -156,7 +156,7 @@ butterfly_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs,
 		u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
 
 /*----------------------------------------------------------------------*/
diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index 7edbd58..82b480c 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -146,25 +146,25 @@ static inline int getmiso(const struct spi_device *spi)
 static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 1, 0, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 1, 0, word, bits);
 }
 
 /*----------------------------------------------------------------------*/
diff --git a/drivers/spi/spi_lm70llp.c b/drivers/spi/spi_lm70llp.c
index 86fb7b5..7746a41 100644
--- a/drivers/spi/spi_lm70llp.c
+++ b/drivers/spi/spi_lm70llp.c
@@ -191,7 +191,7 @@ static void lm70_chipselect(struct spi_device *spi, int value)
  */
 static u32 lm70_txrx(struct spi_device *spi, unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
 
 static void spi_lm70llp_attach(struct parport *p)
diff --git a/drivers/spi/spi_s3c24xx_gpio.c b/drivers/spi/spi_s3c24xx_gpio.c
index 8979a75..be99135 100644
--- a/drivers/spi/spi_s3c24xx_gpio.c
+++ b/drivers/spi/spi_s3c24xx_gpio.c
@@ -64,25 +64,25 @@ static inline u32 getmiso(struct spi_device *dev)
 static u32 s3c2410_spigpio_txrx_mode0(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 s3c2410_spigpio_txrx_mode1(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 s3c2410_spigpio_txrx_mode2(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 1, 0, word, bits);
 }
 
 static u32 s3c2410_spigpio_txrx_mode3(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 1, 0, word, bits);
 }
 
 
diff --git a/drivers/spi/spi_sh_sci.c b/drivers/spi/spi_sh_sci.c
index a511be7..5c64391 100644
--- a/drivers/spi/spi_sh_sci.c
+++ b/drivers/spi/spi_sh_sci.c
@@ -83,25 +83,25 @@ static inline u32 getmiso(struct spi_device *dev)
 static u32 sh_sci_spi_txrx_mode0(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 sh_sci_spi_txrx_mode1(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 0, 0, word, bits);
 }
 
 static u32 sh_sci_spi_txrx_mode2(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha0(spi, nsecs, 1, 0, word, bits);
 }
 
 static u32 sh_sci_spi_txrx_mode3(struct spi_device *spi,
 				      unsigned nsecs, u32 word, u8 bits)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, word, bits);
+	return bitbang_txrx_be_cpha1(spi, nsecs, 1, 0, word, bits);
 }
 
 static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
-- 
1.7.1.240.g225c


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
