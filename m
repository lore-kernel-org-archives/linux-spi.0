From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: reinitialize transfer parameters
	for every message
Date: Fri,  4 Jun 2010 15:13:07 -0500
Message-ID: <1275682387-10681-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

This patch fixes the setup_transfer logic to account for the case where
multiple messages to different SPI devices are queued simultaneously.
With the current logic, the second message in the queue will end up
using the transfer parameters for the previous message in the queue.

The fix is to reinitialize the transfer parameters for each message
rather than only once on the first message.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
---
 drivers/spi/spi_bitbang.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 5265330..8c0c0b8 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -259,7 +259,6 @@ static void bitbang_work(struct work_struct *work)
 	struct spi_bitbang	*bitbang =
 		container_of(work, struct spi_bitbang, work);
 	unsigned long		flags;
-	int			do_setup = -1;
 	int			(*setup_transfer)(struct spi_device *,
 					struct spi_transfer *);
 
@@ -275,6 +274,8 @@ static void bitbang_work(struct work_struct *work)
 		unsigned		tmp;
 		unsigned		cs_change;
 		int			status;
+		int			do_setup = 1;
+		int			restore_param = 0;
 
 		m = container_of(bitbang->queue.next, struct spi_message,
 				queue);
@@ -295,10 +296,11 @@ static void bitbang_work(struct work_struct *work)
 		list_for_each_entry (t, &m->transfers, transfer_list) {
 
 			/* override speed or wordsize? */
-			if (t->speed_hz || t->bits_per_word)
+			if (t->speed_hz || t->bits_per_word) {
 				do_setup = 1;
+				restore_param = 1;
+			}
 
-			/* init (-1) or override (1) transfer params */
 			if (do_setup != 0) {
 				if (!setup_transfer) {
 					status = -ENOPROTOOPT;
@@ -307,6 +309,7 @@ static void bitbang_work(struct work_struct *work)
 				status = setup_transfer(spi, t);
 				if (status < 0)
 					break;
+				do_setup = 0;
 			}
 
 			/* set up default clock polarity, and activate chip;
@@ -368,9 +371,8 @@ static void bitbang_work(struct work_struct *work)
 		m->complete(m->context);
 
 		/* restore speed and wordsize if it was overridden */
-		if (do_setup == 1)
+		if (restore_param == 1)
 			setup_transfer(spi, NULL);
-		do_setup = 0;
 
 		/* normally deactivate chipselect ... unless no error and
 		 * cs_change has hinted that the next message will probably
-- 
1.6.3.3


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
