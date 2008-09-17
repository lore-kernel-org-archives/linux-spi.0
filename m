From: stefano.babic-jEVQdWr+paajF4gvJNWmbkB+6BGkLq7r@public.gmane.org
Subject: [PATCH] The of_register_spi_devices() was not
	called after registering the spi master.
Date: Wed, 17 Sep 2008 19:06:00 +0200
Message-ID: <1221671160-602-1-git-send-email-stefano.babic@babic.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <>
References: <>
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

From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>

Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 25eda71..41f9921 100644
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
+		dev_err(dev,"spi_register_master FAILED\n");
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
+	ret=mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
 					irq_of_parse_and_map(op->node, 0), id);
+	if (ret==0)  {
+		master=spi_busnum_to_master(id);
+		of_register_spi_devices(master, op->node);
+	}
+	return(ret);
 }
 
 static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
