From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: spi-mpc512x-psc: don't use obsolet cell-index property
Date: Fri, 21 Dec 2012 15:43:01 +0100
Message-ID: <1356100981-18685-1-git-send-email-agust@denx.de>
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

Use unique PSCx register base offset to obtain the
SPI PSC number used for SPI bus id.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 0a1e39e..844d68f 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -523,16 +523,21 @@ static int __devinit mpc512x_psc_spi_of_probe(struct platform_device *op)
 
 	/* get PSC id (0..11, used by port_config) */
 	if (op->dev.platform_data == NULL) {
-		const u32 *psc_nump;
+		u32 reg;
+		int err;
 
-		psc_nump = of_get_property(op->dev.of_node, "cell-index", NULL);
-		if (!psc_nump || *psc_nump > 11) {
-			dev_err(&op->dev, "mpc512x_psc_spi: Device node %s "
-				"has invalid cell-index property\n",
+		err =  of_property_read_u32(op->dev.of_node, "reg", &reg);
+		if (err) {
+			dev_err(&op->dev, "Can't read reg property: %d\n", err);
+			return err;
+		}
+
+		id = (reg & 0xf00) >> 8;
+		if (id > 11) {
+			dev_err(&op->dev, "node %s has invalid reg property\n",
 				op->dev.of_node->full_name);
 			return -EINVAL;
 		}
-		id = *psc_nump;
 	}
 
 	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
-- 
1.7.7.6


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
