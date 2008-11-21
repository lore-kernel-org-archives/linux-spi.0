From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc6] spi: mpc52xx_psc_spi
	chipselect bugfix
Date: Thu, 20 Nov 2008 21:26:22 -0800
Message-ID: <200811202126.23121.david-b@pacbell.net>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>

According to the manual the "tdfOnExit" flag must be set on the last byte
we want to send. The PSC controller holds SS low until the flag is set.

However, the flag was set always on the last byte of the FIFO, independently if
it is the last byte of the transfer. This generates spurious toggling of the
SS signals that breaks the protocol of some peripherals.  Fix.

Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -142,6 +142,7 @@ static int mpc52xx_psc_spi_transfer_rxtx
 	unsigned rfalarm;
 	unsigned send_at_once = MPC52xx_PSC_BUFSIZE;
 	unsigned recv_at_once;
+	int last_block = 0;
 
 	if (!t->tx_buf && !t->rx_buf && t->len)
 		return -EINVAL;
@@ -151,15 +152,17 @@ static int mpc52xx_psc_spi_transfer_rxtx
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

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
