From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: Correct SPI clock frequency
	setting in spi_mpc8xxx
Date: Mon, 15 Feb 2010 17:23:04 +0100
Message-ID: <20100215172304.66663326.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Correct SPI clock frequency division factor rounding, preventing clock rates 
higher than the maximum specified clock frequency being used. 

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
Tested on MPC8314.

diff -up linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c linux-2.6.33-rc8/drivers/spi/spi_mpc8xxx.c
--- linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c	2010-02-12 20:07:45.000000000 +0100
+++ linux-2.6.33-rc8/drivers/spi/spi_mpc8xxx.c	2010-02-15 14:08:33.000000000 +0100
@@ -365,7 +365,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
 
 	if ((mpc8xxx_spi->spibrg / hz) > 64) {
 		cs->hw_mode |= SPMODE_DIV16;
-		pm = mpc8xxx_spi->spibrg / (hz * 64);
+		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 64) + 1;
 
 		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
 			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
@@ -373,7 +373,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
 		if (pm > 16)
 			pm = 16;
 	} else
-		pm = mpc8xxx_spi->spibrg / (hz * 4);
+		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1;
 	if (pm)
 		pm--;
 


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
