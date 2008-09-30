From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] mpc52xx_psc_spi setting the tdfOnExit
	flag only on the last byte
Date: Tue, 30 Sep 2008 11:22:52 +0200
Message-ID: <1222766572-17499-2-git-send-email-sbabic@denx.de>
References: <>
 <1222766572-17499-1-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1222766572-17499-1-git-send-email-sbabic-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 41f9921..d7b1fb5 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -149,6 +148,7 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 	unsigned rfalarm;
 	unsigned send_at_once = MPC52xx_PSC_BUFSIZE;
 	unsigned recv_at_once;
+	int last_block = 0;
 
 	if (!t->tx_buf && !t->rx_buf && t->len)
 		return -EINVAL;
@@ -158,15 +158,17 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 	while (rb < t->len) {
 		if (t->len - rb > MPC52xx_PSC_BUFSIZE) {
 			rfalarm = MPC52xx_PSC_RFALARM;
+			last_block = 0;
 		} else {
 			send_at_once = t->len - sb;
 			rfalarm = MPC52xx_PSC_BUFSIZE - (t->len - rb);
+			last_block = 1;
 		}
 
 		dev_dbg(&spi->dev, "send %d bytes...\n", send_at_once);
 		for (; send_at_once; sb++, send_at_once--) {
 			/* set EOF flag before the last word is sent */
-			if (send_at_once == 1)
+			if (send_at_once == 1 && last_block)
 				out_8(&psc->ircr2, 0x01);
 
 			if (tx_buf)
-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
