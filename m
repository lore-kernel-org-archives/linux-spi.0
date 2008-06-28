From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-rc8] spi: spi_mpc83xx clockrate
	fixes
Date: Fri, 27 Jun 2008 18:21:50 -0700
Message-ID: <200806271821.50913.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] fix spi_mpc83xx prescale

This updates the SPI clock rate calculations for the spi_mpc83xx
driver.  Some boundary conditions were wrong, and in several cases
divide-by-16 wasn't always needed

Signed-off-by: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/drivers/spi/spi_mpc83xx.c	2008-05-13 15:17:37.000000000 -0700
+++ b/drivers/spi/spi_mpc83xx.c	2008-06-27 18:17:17.000000000 -0700
@@ -266,21 +266,24 @@ int mpc83xx_spi_setup_transfer(struct sp
 
 	cs->hw_mode |= SPMODE_LEN(bits_per_word);
 
-	if ((mpc83xx_spi->spibrg / hz) >= 64) {
-		pm = mpc83xx_spi->spibrg / (hz * 64) - 1;
-		if (pm > 0x0f) {
-			dev_err(&spi->dev, "Requested speed is too "
-				"low: %d Hz. Will use %d Hz instead.\n",
-				hz, mpc83xx_spi->spibrg / 1024);
-			pm = 0x0f;
+	if ((mpc83xx_spi->spibrg / hz) > 64) {
+		pm = mpc83xx_spi->spibrg / (hz * 64);
+		if (pm > 16) {
+			cs->hw_mode |= SPMODE_DIV16;
+			pm /= 16;
+			if (pm > 16) {
+				dev_err(&spi->dev, "Requested speed is too "
+					"low: %d Hz. Will use %d Hz instead.\n",
+					hz, mpc83xx_spi->spibrg / 1024);
+				pm = 16;
+			}
 		}
-		cs->hw_mode |= SPMODE_PM(pm) | SPMODE_DIV16;
-	} else {
+	} else
 		pm = mpc83xx_spi->spibrg / (hz * 4);
-		if (pm)
-			pm--;
-		cs->hw_mode |= SPMODE_PM(pm);
-	}
+	if (pm)
+		pm--;
+
+	cs->hw_mode |= SPMODE_PM(pm);
 	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 	if (cs->hw_mode != regval) {
 		unsigned long flags;

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
