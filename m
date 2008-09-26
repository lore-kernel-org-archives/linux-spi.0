From: sbabic-ynQEQJNshbs@public.gmane.org
Subject: [PATCH] The of_register_spi_devices() was not
	called after registering the spi master.
Date: Fri, 26 Sep 2008 10:24:40 +0200
Message-ID: <1222417480-3144-2-git-send-email-sbabic@denx.de>
References: <1222417480-3144-1-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1222417480-3144-1-git-send-email-sbabic-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>

Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 25eda71..5d233e7 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -18,6 +18,7 @@
 
 #if defined(CONFIG_PPC_MERGE)
 #include <linux/of_platform.h>
+#include <linux/of_spi.h>
 #else
 #include <linux/platform_device.h>
 #endif
@@ -439,8 +440,10 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	}
 
 	ret = spi_register_master(master);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "spi_register_master FAILED\n");
 		goto unreg_master;
+	}
 
 	return ret;
 
@@ -524,6 +527,8 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
 	s16 id = -1;
+	struct spi_master *master;
+	int ret;
 
 	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
 	if (!regaddr_p) {
@@ -545,8 +550,13 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 		id = *psc_nump + 1;
 	}
 
-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
-					irq_of_parse_and_map(op->node, 0), id);
+	if ((ret = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
+					irq_of_parse_and_map(op->node, 0), id)))
+		return ret;
+	master = spi_busnum_to_master(id);
+	of_register_spi_devices(master, op->node);
+
+	return 0;
 }
 
 static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
