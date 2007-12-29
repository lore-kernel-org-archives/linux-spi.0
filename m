From: Dave Young <hidave.darkstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/12] spi : Use mutex instead of
	semaphore in driver core
Date: Sat, 29 Dec 2007 09:18:58 +0800
Message-ID: <20071229011858.GL2883@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Dave Young <hidave.darkstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 

---
drivers/spi/spi.c |    4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff -upr linux/drivers/spi/spi.c linux.new/drivers/spi/spi.c
--- linux/drivers/spi/spi.c	2007-12-28 10:47:38.000000000 +0800
+++ linux.new/drivers/spi/spi.c	2007-12-28 10:48:22.000000000 +0800
@@ -494,7 +494,7 @@ struct spi_master *spi_busnum_to_master(
 	struct spi_master	*master = NULL;
 	struct spi_master	*m;
 
-	down(&spi_master_class.sem);
+	mutex_lock(&spi_master_class.mutex);
 	list_for_each_entry(dev, &spi_master_class.children, node) {
 		m = container_of(dev, struct spi_master, dev);
 		if (m->bus_num == bus_num) {
@@ -502,7 +502,7 @@ struct spi_master *spi_busnum_to_master(
 			break;
 		}
 	}
-	up(&spi_master_class.sem);
+	mutex_unlock(&spi_master_class.mutex);
 	return master;
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
