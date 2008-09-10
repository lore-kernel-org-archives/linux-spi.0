From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH] spi_mpc83xx: handle odd transfer sizes
Date: Wed, 10 Sep 2008 22:31:07 +0200
Message-ID: <1221078668-11680-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Error out on transfer length != multiple of bytes per word with -EINVAL.
Fixes a buffer overrun crash if length < bytes per word.

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Acked-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

David, is this more 
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 070c621..11c246f 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -315,11 +315,20 @@ static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (t->bits_per_word)
 		bits_per_word = t->bits_per_word;
 	len = t->len;
-	if (bits_per_word > 8)
+	if (bits_per_word > 8) {
+		/* invalid length? */
+		if (len & 1)
+			return -EINVAL;
 		len /= 2;
-	if (bits_per_word > 16)
+	}
+	if (bits_per_word > 16) {
+		/* invalid length? */
+		if (len & 1)
+			return -EINVAL;
 		len /= 2;
+	}
 	mpc83xx_spi->count = len;
+
 	INIT_COMPLETION(mpc83xx_spi->done);
 
 	/* enable rx ints */
@@ -376,7 +385,8 @@ static void mpc83xx_spi_work(struct work_struct *work)
 			if (t->len)
 				status = mpc83xx_spi_bufs(spi, t);
 			if (status) {
-				status = -EMSGSIZE;
+				if (status > 0)
+					status = -EMSGSIZE;
 				break;
 			}
 			m->actual_length += t->len;
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
