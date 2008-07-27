From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-git] mpc52xx_psc_spi: fix block
	transfer
Date: Sun, 27 Jul 2008 15:22:05 -0700
Message-ID: <200807271522.05967.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

From: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

The block transfer routine in the mpc52xx psc spi driver misinterpret the
datasheet. According to the processor datasheet the chipselect is held as
long as the EOF is not written. Theoretically block of any sizes can be
transferred in this way. The old routine however writes an EOF after every
word, which has the size of size_of_word. This makes the transfer slow.
Also fixed some duplicate code.

Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- a/drivers/spi/mpc52xx_psc_spi.c	2008-07-24 18:27:52.000000000 -0700
+++ b/drivers/spi/mpc52xx_psc_spi.c	2008-07-27 15:16:29.000000000 -0700
@@ -148,7 +148,6 @@ static int mpc52xx_psc_spi_transfer_rxtx
 	unsigned rfalarm;
 	unsigned send_at_once = MPC52xx_PSC_BUFSIZE;
 	unsigned recv_at_once;
-	unsigned bpw = mps->bits_per_word / 8;
 
 	if (!t->tx_buf && !t->rx_buf && t->len)
 		return -EINVAL;
@@ -164,22 +163,15 @@ static int mpc52xx_psc_spi_transfer_rxtx
 		}
 
 		dev_dbg(&spi->dev, "send %d bytes...\n", send_at_once);
-		if (tx_buf) {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& (sb + 1) % bpw == 0)
-					out_8(&psc->ircr2, 0x01);
+		for (; send_at_once; sb++, send_at_once--) {
+			/* set EOF flag before the last word is sent */
+			if (send_at_once == 1)
+				out_8(&psc->ircr2, 0x01);
+
+			if (tx_buf)
 				out_8(&psc->mpc52xx_psc_buffer_8, tx_buf[sb]);
-			}
-		} else {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& ((sb + 1) % bpw) == 0)
-					out_8(&psc->ircr2, 0x01);
+			else
 				out_8(&psc->mpc52xx_psc_buffer_8, 0);
-			}
 		}
 
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
