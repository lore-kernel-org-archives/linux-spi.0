From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH 2/3] spi: bitbang: (cosmetic) simplify list manipulation
Date: Mon, 21 May 2012 13:25:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205211323460.30522@axis700.grange>
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

Use a proper list iterator instead of an open-coded loop and remove a
superfluous list head initialisation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi-bitbang.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index f5ae6e9..8b3d8ef 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -260,11 +260,11 @@ static void bitbang_work(struct work_struct *work)
 	struct spi_bitbang	*bitbang =
 		container_of(work, struct spi_bitbang, work);
 	unsigned long		flags;
+	struct spi_message	*m, *_m;
 
 	spin_lock_irqsave(&bitbang->lock, flags);
 	bitbang->busy = 1;
-	while (!list_empty(&bitbang->queue)) {
-		struct spi_message	*m;
+	list_for_each_entry_safe(m, _m, &bitbang->queue, queue) {
 		struct spi_device	*spi;
 		unsigned		nsecs;
 		struct spi_transfer	*t = NULL;
@@ -273,9 +273,7 @@ static void bitbang_work(struct work_struct *work)
 		int			status;
 		int			do_setup = -1;
 
-		m = container_of(bitbang->queue.next, struct spi_message,
-				queue);
-		list_del_init(&m->queue);
+		list_del(&m->queue);
 		spin_unlock_irqrestore(&bitbang->lock, flags);
 
 		/* FIXME this is made-up ... the correct value is known to
-- 
1.7.2.5


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
