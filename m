From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: reinitialize transfer parameters
	for each message
Date: Tue,  9 Mar 2010 16:56:15 -0600
Message-ID: <1268175375-13970-1-git-send-email-bniebuhr@efjohnson.com>
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

It is possible that multiple messages for different SPI devices could
be queued.  The transfer parameters are currently only set for the
first message in the bitbang work queue.  If subsequent messages in
the queue are for devices that do not have compatible transfer
parameters (speed, phase, polarity, etc.) then those transfers will fail.

The fix is to reinitialize the transfer parameters for each message
rather than only once on the first message.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
---
 drivers/spi/spi_bitbang.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index f1db395..1e9247a 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -258,7 +258,6 @@ static void bitbang_work(struct work_struct *work)
 	struct spi_bitbang	*bitbang =
 		container_of(work, struct spi_bitbang, work);
 	unsigned long		flags;
-	int			do_setup = -1;
 	int			(*setup_transfer)(struct spi_device *,
 					struct spi_transfer *);
 
@@ -274,6 +273,7 @@ static void bitbang_work(struct work_struct *work)
 		unsigned		tmp;
 		unsigned		cs_change;
 		int			status;
+		int			do_setup = -1;
 
 		m = container_of(bitbang->queue.next, struct spi_message,
 				queue);
-- 
1.6.3.3


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
