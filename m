From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH] spi: Fix comparison of different integer types
Date: Thu,  6 Dec 2012 23:35:47 +0000
Message-ID: <1354836947-31078-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Fix problem discovered with sparse:
+ drivers/spi/spi.c:1554:37: sparse: incompatible types in comparison expression (different signedness)
drivers/spi/spi.c: In function 'spi_write_then_read':
drivers/spi/spi.c:1554:23: warning: comparison of distinct pointer types lacks a cast [enabled by default]

The change to SPI_BUFSIZ was introduced in commit b3a223ee2, "spi:
Remove SPI_BUFSIZ restriction on spi_write_then_read()"

Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/spi/spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 22c71e2..b370d292 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1551,7 +1551,7 @@ int spi_write_then_read(struct spi_device *spi,
 	 * using the pre-allocated buffer or the transfer is too large.
 	 */
 	if ((n_tx + n_rx) > SPI_BUFSIZ || !mutex_trylock(&lock)) {
-		local_buf = kmalloc(max(SPI_BUFSIZ, n_tx + n_rx), GFP_KERNEL);
+		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx), GFP_KERNEL);
 		if (!local_buf)
 			return -ENOMEM;
 	} else {
-- 
1.7.10.4


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
