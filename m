From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc7] orion_spi: handle 88F6183
	erratum
Date: Wed, 24 Sep 2008 22:14:43 -0700
Message-ID: <200809242214.43198.david-b@pacbell.net>
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

From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>

The patch below adds support to orion_spi for the 88F6183 ARM SoC
by adding code to work around a 6183-specific erratum.

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
this is for the 2.6.28-rc0 merge window ...

 drivers/spi/orion_spi.c       |    5 +++++
 include/linux/spi/orion_spi.h |    1 +
 2 files changed, 6 insertions(+)

--- a/drivers/spi/orion_spi.c
+++ b/drivers/spi/orion_spi.c
@@ -364,6 +364,11 @@ static int orion_spi_setup(struct spi_de
 		return -EINVAL;
 	}
 
+	/* Fix ac timing if required.   */
+	if (orion_spi->spi_info->enable_clock_fix)
+		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  (1 << 14));
+
 	if (spi->bits_per_word == 0)
 		spi->bits_per_word = 8;
 
--- a/include/linux/spi/orion_spi.h
+++ b/include/linux/spi/orion_spi.h
@@ -11,6 +11,7 @@
 
 struct orion_spi_info {
 	u32	tclk;		/* no <linux/clk.h> support yet */
+	u32	enable_clock_fix;
 };
 
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
