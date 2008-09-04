From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH] spi_mpc83xx: fix clockrate calculation
	for low speed
Date: Thu,  4 Sep 2008 15:49:00 +0200
Message-ID: <1220536140-18289-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
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

Commit a61f5345 (spi_mpc83xx clockrate fixes) broke clockrate
calculation for low speeds. SPMODE_DIV16 should be set if the
divider is higher than 64, not only if the divider gets clipped
to 1024.

Furthermore, the clipping check was off by a factor 16 as well.

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 070c621..ab7ee44 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -267,16 +267,13 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	cs->hw_mode |= SPMODE_LEN(bits_per_word);
 
 	if ((mpc83xx_spi->spibrg / hz) > 64) {
+		cs->hw_mode |= SPMODE_DIV16;
 		pm = mpc83xx_spi->spibrg / (hz * 64);
 		if (pm > 16) {
-			cs->hw_mode |= SPMODE_DIV16;
-			pm /= 16;
-			if (pm > 16) {
-				dev_err(&spi->dev, "Requested speed is too "
-					"low: %d Hz. Will use %d Hz instead.\n",
-					hz, mpc83xx_spi->spibrg / 1024);
-				pm = 16;
-			}
+			dev_err(&spi->dev, "Requested speed is too "
+				"low: %d Hz. Will use %d Hz instead.\n",
+				hz, mpc83xx_spi->spibrg / 1024);
+			pm = 16;
 		}
 	} else
 		pm = mpc83xx_spi->spibrg / (hz * 4);
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
