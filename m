From: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] fix mpc83xx spi prescale modulus
	calculate
Date: Fri, 20 Jun 2008 18:35:45 +0800
Message-ID: <1213958145-18592-1-git-send-email-g.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Signed-off-by: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 6832da6..070c621 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -266,21 +266,24 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
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
-- 
1.5.4


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
