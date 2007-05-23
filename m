From: Domen Puncer <domen.puncer-P35k8AZwkyRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi/spidev: check message size before
	copying
Date: Wed, 23 May 2007 07:58:44 +0200
Message-ID: <20070523055844.GA5514@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Resent-Message-Id: <20070523061059.4046DBEE65-IR7e1bascun4oxQW5iQ/GQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Message size needs to be checked before copying, or bad
things could happen.


Signed-off-by: Domen Puncer <domen.puncer-P35k8AZwkyRBDgjK7y7TUQ@public.gmane.org>

---
 drivers/spi/spidev.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: work-powerpc.git/drivers/spi/spidev.c
===================================================================
--- work-powerpc.git.orig/drivers/spi/spidev.c
+++ work-powerpc.git/drivers/spi/spidev.c
@@ -168,6 +168,12 @@ static int spidev_message(struct spidev_
 			n--, k_tmp++, u_tmp++) {
 		k_tmp->len = u_tmp->len;
 
+		total += k_tmp->len;
+		if (total > bufsiz) {
+			status = -EMSGSIZE;
+			goto done;
+		}
+
 		if (u_tmp->rx_buf) {
 			k_tmp->rx_buf = buf;
 			if (!access_ok(VERIFY_WRITE, u_tmp->rx_buf, u_tmp->len))
@@ -179,12 +185,6 @@ static int spidev_message(struct spidev_
 					u_tmp->len))
 				goto done;
 		}
-
-		total += k_tmp->len;
-		if (total > bufsiz) {
-			status = -EMSGSIZE;
-			goto done;
-		}
 		buf += k_tmp->len;
 
 		k_tmp->cs_change = !!u_tmp->cs_change;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
