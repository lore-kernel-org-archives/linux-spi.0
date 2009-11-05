From: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH 4/6] SPI: spi_txx9: Fix bit rate
	calculation
Date: Thu, 05 Nov 2009 16:26:00 +0100
Message-ID: <20091105152702.283954757@linux-mips.org>
References: <20091105152555.227009519@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=0005.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>

TXx9 SPI bit rate is calculated by:
        fBR = (spi-baseclk) / (n + 1)
Fix calculation of min_speed_hz, max_speed_hz and n.

Signed-off-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>

 drivers/spi/spi_txx9.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: upstream-linus/drivers/spi/spi_txx9.c
===================================================================
--- upstream-linus.orig/drivers/spi/spi_txx9.c
+++ upstream-linus/drivers/spi/spi_txx9.c
@@ -29,6 +29,8 @@
 
 
 #define SPI_FIFO_SIZE 4
+#define SPI_MAX_DIVIDER 0xff	/* Max. value for SPCR1.SER */
+#define SPI_MIN_DIVIDER 1	/* Min. value for SPCR1.SER */
 
 #define TXx9_SPMCR		0x00
 #define TXx9_SPCR0		0x04
@@ -193,11 +195,8 @@ static void txx9spi_work_one(struct txx9
 
 		if (prev_speed_hz != speed_hz
 				|| prev_bits_per_word != bits_per_word) {
-			u32 n = (c->baseclk + speed_hz - 1) / speed_hz;
-			if (n < 1)
-				n = 1;
-			else if (n > 0xff)
-				n = 0xff;
+			int n = DIV_ROUND_UP(c->baseclk, speed_hz) - 1;
+			n = clamp(n, SPI_MIN_DIVIDER, SPI_MAX_DIVIDER);
 			/* enter config mode */
 			txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR,
 					TXx9_SPMCR);
@@ -370,8 +369,8 @@ static int __init txx9spi_probe(struct p
 		goto exit;
 	}
 	c->baseclk = clk_get_rate(c->clk);
-	c->min_speed_hz = (c->baseclk + 0xff - 1) / 0xff;
-	c->max_speed_hz = c->baseclk;
+	c->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
+	c->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
