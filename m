From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: spi-mpc512x-psc: let transmiter/receiver enabled when in
	xfer loop
Date: Mon,  1 Apr 2013 17:31:19 +0200
Message-ID: <1364830279-15130-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

There is no need to disable transmitter/receiver after each loop
iteration and re-enable it for next loop iteration. Enable the
transmitter/receiver before xfer loop starts and disable it when
the whole transfer is done.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 3e490ee..0ea7c81 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -148,6 +148,9 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	in_8(&psc->mode);
 	out_8(&psc->mode, 0x0);
 
+	/* enable transmiter/receiver */
+	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+
 	while (len) {
 		int count;
 		int i;
@@ -176,10 +179,6 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
 		out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
 
-		/* enable transmiter/receiver */
-		out_8(&psc->command,
-		      MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
-
 		wait_for_completion(&mps->done);
 
 		mdelay(1);
@@ -204,9 +203,6 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 		while (in_be32(&fifo->rxcnt)) {
 			in_8(&fifo->rxdata_8);
 		}
-
-		out_8(&psc->command,
-		      MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
 	}
 	/* disable transmiter/receiver and fifo interrupt */
 	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
-- 
1.7.5.4


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
