From: Dave Young <hidave.darkstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6] spi : use class iteration api
Date: Tue, 22 Jan 2008 15:14:18 +0800
Message-ID: <20080122071418.GA3725@darkstar.te-china.tietoenator.com>
References: <20080112095711.GF2893@darkstar.te-china.tietoenator.com>
	<20080122060331.GG3066@darkstar.te-china.tietoenator.com>
	<200801212256.11484.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200801212256.11484.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Convert to use the class iteration api.

Signed-off-by: Dave Young <hidave.darkstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 

---
 drivers/spi/spi.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff -upr linux/drivers/spi/spi.c linux.new/drivers/spi/spi.c
--- linux/drivers/spi/spi.c	2008-01-22 15:09:49.000000000 +0800
+++ linux.new/drivers/spi/spi.c	2008-01-22 15:09:49.000000000 +0800
@@ -485,6 +485,15 @@ void spi_unregister_master(struct spi_ma
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
+static int __spi_master_match(struct device *dev, void *data)
+{
+	struct spi_master *m;
+	u16 *bus_num = data;
+
+	m = container_of(dev, struct spi_master, dev);
+	return m->bus_num == *bus_num;
+}
+
 /**
  * spi_busnum_to_master - look up master associated with bus_num
  * @bus_num: the master's bus number
@@ -499,17 +508,12 @@ struct spi_master *spi_busnum_to_master(
 {
 	struct device		*dev;
 	struct spi_master	*master = NULL;
-	struct spi_master	*m;
 
-	down(&spi_master_class.sem);
-	list_for_each_entry(dev, &spi_master_class.children, node) {
-		m = container_of(dev, struct spi_master, dev);
-		if (m->bus_num == bus_num) {
-			master = spi_master_get(m);
-			break;
-		}
-	}
-	up(&spi_master_class.sem);
+	dev = class_find_device(&spi_master_class, &bus_num,
+				__spi_master_match);
+	if (dev)
+		master = container_of(dev, struct spi_master, dev);
+	/* reference got in class_find_device */
 	return master;
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
