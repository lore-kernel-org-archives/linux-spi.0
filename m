From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: Trivial warning fix
Date: Mon, 27 Feb 2012 19:29:05 +0530
Message-ID: <1330351145-3564-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vitaly Wool <vwool-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

The loop count i traverses for ntrans which is unsigned
so make the loop count i also unsigned.

Fix the below warning
In file included from drivers/spi/spi-omap2-mcspi.c:38:
include/linux/spi/spi.h: In function 'spi_message_alloc':
include/linux/spi/spi.h:556: warning: comparison between signed and unsigned integer expressions

Cc: Vitaly Wool <vwool-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Untested !

 include/linux/spi/spi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..6ae4993 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -549,7 +549,7 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
 			+ ntrans * sizeof(struct spi_transfer),
 			flags);
 	if (m) {
-		int i;
+		unsigned i;
 		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
 
 		INIT_LIST_HEAD(&m->transfers);
-- 
1.7.0.4


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
