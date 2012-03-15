From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 1/2] spi/fsl-espi: make the clock computation easier to read
Date: Thu, 15 Mar 2012 18:42:31 +0100
Message-ID: <1331833352-15058-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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

The -1 +1 thingy should probably do what DIV_ROUND_UP does. The 4 is 2
the  "platform_clock => sysclock" and 2 from the computation part. The 64
is the same 4 times 16.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d770f03..43350f9 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -180,7 +180,7 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 
 	if ((mpc8xxx_spi->spibrg / hz) > 64) {
 		cs->hw_mode |= CSMODE_DIV16;
-		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 64) + 1;
+		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4);
 
 		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
 			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
@@ -188,7 +188,7 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 		if (pm > 16)
 			pm = 16;
 	} else {
-		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1;
+		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4);
 	}
 	if (pm)
 		pm--;
-- 
1.7.9.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
