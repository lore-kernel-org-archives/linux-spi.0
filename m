From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [RFC,
	PATCH 1/2] SPI: orion_spi: support for 88F6183
Date: Tue, 16 Sep 2008 15:28:29 +0200
Message-ID: <20080916132829.GA19493@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, nico-mo2vmkxb4K0@public.gmane.org, saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
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

The patch below adds support to orion_spi for the 88F6183 ARM SoC
by adding code to work around a 6183-specific erratum.

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/spi/orion_spi.c b/drivers/spi/orion_spi.c
index c4eaacd..e33412a 100644
--- a/drivers/spi/orion_spi.c
+++ b/drivers/spi/orion_spi.c
@@ -364,6 +364,11 @@ static int orion_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	/* Fix ac timing if required.   */
+	if (orion_spi->spi_info->enable_clock_fix)
+		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  (1 << 14));
+
 	if (spi->bits_per_word == 0)
 		spi->bits_per_word = 8;
 
diff --git a/include/linux/spi/orion_spi.h b/include/linux/spi/orion_spi.h
index b4d9fa6..decf6d8 100644
--- a/include/linux/spi/orion_spi.h
+++ b/include/linux/spi/orion_spi.h
@@ -11,6 +11,7 @@
 
 struct orion_spi_info {
 	u32	tclk;		/* no <linux/clk.h> support yet */
+	u32	enable_clock_fix;
 };
 
 
-- 
1.5.6.4

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
