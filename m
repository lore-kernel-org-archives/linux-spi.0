From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi: dw_spi: fix a bug in
	wait_till_not_busy()
Date: Tue, 19 Jan 2010 11:20:01 +0800
Message-ID: <20100119112001.6c391ea7@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Grant Likely
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

>From 124fda393891d31debc2a3b760627edb18422203 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Fri, 25 Dec 2009 11:18:32 +0800
Subject: [PATCH 1/3] spi: dw_spi: fix a bug in wait_till_not_busy()

Make the driver wait at least  for 1 jiffie before issuing the
warning, no matter what HZ is set to

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/dw_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 31620fa..521d680 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -161,7 +161,7 @@ static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
 
 static void wait_till_not_busy(struct dw_spi *dws)
 {
-	unsigned long end = jiffies + usecs_to_jiffies(1000);
+	unsigned long end = jiffies + 1 + usecs_to_jiffies(1000);
 
 	while (time_before(jiffies, end)) {
 		if (!(dw_readw(dws, sr) & SR_BUSY))
-- 
1.6.0.4

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
