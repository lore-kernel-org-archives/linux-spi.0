From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH] spi_mpc83xx: handle odd transfer sizes
Date: Wed, 10 Sep 2008 11:17:30 +0200
Message-ID: <1221038250-11656-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
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

Make spi_mpc83xx more robust against odd transfer sizes:
- Error out on transfer length != multiple of bytes per word
- Fix crash on transfer length = 0 (1 word was always sent and
  length decremented before check against 0).

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 070c621..35067a5 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -315,24 +315,35 @@ static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (t->bits_per_word)
 		bits_per_word = t->bits_per_word;
 	len = t->len;
-	if (bits_per_word > 8)
+	if (bits_per_word > 8) {
+		/* invalid length? */
+		if (len & 1)
+			return len;
 		len /= 2;
-	if (bits_per_word > 16)
+	}
+	if (bits_per_word > 16) {
+		/* invalid length? */
+		if (len & 1)
+			return len;
 		len /= 2;
+	}
 	mpc83xx_spi->count = len;
-	INIT_COMPLETION(mpc83xx_spi->done);
 
-	/* enable rx ints */
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, SPIM_NE);
+	if (len) {
+		INIT_COMPLETION(mpc83xx_spi->done);
+
+		/* enable rx ints */
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, SPIM_NE);
 
-	/* transmit word */
-	word = mpc83xx_spi->get_tx(mpc83xx_spi);
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->transmit, word);
+		/* transmit word */
+		word = mpc83xx_spi->get_tx(mpc83xx_spi);
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->transmit, word);
 
-	wait_for_completion(&mpc83xx_spi->done);
+		wait_for_completion(&mpc83xx_spi->done);
 
-	/* disable rx ints */
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
+		/* disable rx ints */
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
+	}
 
 	return mpc83xx_spi->count;
 }
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
