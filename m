From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH 1/3] spi: bitbang: avoid needless loop flow manipulations
Date: Mon, 21 May 2012 13:25:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205211322570.30522@axis700.grange>
References: <Pine.LNX.4.64.1205211319520.30522@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1205211319520.30522-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch makes a loop look cleaner by replacing a "break" and a "continue"
in its body by a single "if".

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi-bitbang.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index aef59b1..f5ae6e9 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -346,17 +346,14 @@ static void bitbang_work(struct work_struct *work)
 			if (t->delay_usecs)
 				udelay(t->delay_usecs);
 
-			if (!cs_change)
-				continue;
-			if (t->transfer_list.next == &m->transfers)
-				break;
-
-			/* sometimes a short mid-message deselect of the chip
-			 * may be needed to terminate a mode or command
-			 */
-			ndelay(nsecs);
-			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-			ndelay(nsecs);
+			if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
+				/* sometimes a short mid-message deselect of the chip
+				 * may be needed to terminate a mode or command
+				 */
+				ndelay(nsecs);
+				bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+				ndelay(nsecs);
+			}
 		}
 
 		m->status = status;
-- 
1.7.2.5


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
