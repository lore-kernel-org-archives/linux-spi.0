From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 2/7] SD 4wire bugfix
Date: Mon, 4 Jun 2007 20:28:24 -0700
Message-ID: <200706042028.24793.david-b@pacbell.net>
References: <200706042025.18252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706042025.18252.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
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

Once upon a debug dreary, while I pondered weak and weary,
Over many a quaint and curious volume of forgotten lore--
While I nodded, nearly napping, suddenly there came a trapping,
As of some code gently thrashing, thrashing at a chip once more.
"'Tis some bugginess," I muttered, "trapping MMC_CAP_4
    Only this, and nothing more."

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Sent already to Pierre ... this should get into 2.6.22-rc5!

 drivers/mmc/core/sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- g26.orig/drivers/mmc/core/sd.c	2007-05-06 08:27:52.000000000 -0700
+++ g26/drivers/mmc/core/sd.c	2007-06-04 19:58:43.000000000 -0700
@@ -402,7 +402,7 @@ static int mmc_sd_init_card(struct mmc_h
 	/*
 	 * Switch to wider bus (if supported).
 	 */
-	if ((host->caps && MMC_CAP_4_BIT_DATA) &&
+	if ((host->caps & MMC_CAP_4_BIT_DATA) &&
 		(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
 		err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
 		if (err != MMC_ERR_NONE)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
