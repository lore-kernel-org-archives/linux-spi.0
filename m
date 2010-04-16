From: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: release device claimed by
	bus_find_device_by_name
Date: Fri, 16 Apr 2010 12:52:59 +0300
Message-ID: <1271411579-30294-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
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

In success case the function bus_find_device_by_name calls
get_device. In our context put_device should be called to
decrease the device count usage.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9ffb0fd..ec429d1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -257,6 +257,7 @@ int spi_add_device(struct spi_device *spi)
 {
 	static DEFINE_MUTEX(spi_add_lock);
 	struct device *dev = spi->master->dev.parent;
+	struct device *d;
 	int status;
 
 	/* Chipselects are numbered 0..max; validate. */
@@ -278,10 +279,11 @@ int spi_add_device(struct spi_device *spi)
 	 */
 	mutex_lock(&spi_add_lock);
 
-	if (bus_find_device_by_name(&spi_bus_type, NULL, dev_name(&spi->dev))
-			!= NULL) {
+	d = bus_find_device_by_name(&spi_bus_type, NULL, dev_name(&spi->dev));
+	if (d != NULL) {
 		dev_err(dev, "chipselect %d already in use\n",
 				spi->chip_select);
+		put_device(d);
 		status = -EBUSY;
 		goto done;
 	}
-- 
1.6.2.rc1.3.g81d3f


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
