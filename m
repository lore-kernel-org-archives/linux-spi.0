From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 08/11] spi-dw: Ensure fifo lenght is set.
Date: Wed, 22 Jun 2011 19:00:10 -0700
Message-ID: <1308794413-11069-9-git-send-email-dirk.brandewie@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1308794413-11069-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Bug on fifo_len not being set.  The fifo sizing routine does not work
since the txfltr register can not be written while the controller is
enabled. The max value of txfltr can be larger than the fifo.  The
register allows values upto 0x3f (63) the fifo depth on the Intel
SOC's if 40

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-dw.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index ad92826..cc38aa0 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -776,25 +776,11 @@ static int destroy_queue(struct spi_dw *dws)
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void spi_dw_hw_init(struct spi_dw *dws)
 {
+	BUG_ON(!dws->fifo_len);
+
 	spi_dw_disable(dws);
 	spi_dw_mask_intr(dws, 0xff);
 	spi_dw_enable(dws);
-
-	/*
-	 * Try to detect the FIFO depth if not set by interface driver,
-	 * the depth could be from 2 to 256 from HW spec
-	 */
-	if (!dws->fifo_len) {
-		u32 fifo;
-		for (fifo = 2; fifo <= 257; fifo++) {
-			dw_writew(dws, txfltr, fifo);
-			if (fifo != dw_readw(dws, txfltr))
-				break;
-		}
-
-		dws->fifo_len = (fifo == 257) ? 0 : fifo;
-		dw_writew(dws, txfltr, 0);
-	}
 }
 
 int __devinit spi_dw_add_host(struct spi_dw *dws)
-- 
1.7.3.4


------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger.
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today.
http://p.sf.net/sfu/quest-sfdev2dev
