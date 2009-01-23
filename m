From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 6/6] powerpc/fsl_soc: Isolate legacy
	fsl_spi support to	mpc832x_rdb boards
Date: Fri, 23 Jan 2009 22:50:41 +0300
Message-ID: <20090123195041.GF21237@oksana.dev.rtsoft.ru>
References: <20090123194958.GA17355@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123194958.GA17355-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The advantages of this:
- Don't encourage legacy support;
- Less external symbols, less code to compile-in for !MPC832x_RDB
  platforms.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  107 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c             |  107 -----------------------------
 arch/powerpc/sysdev/fsl_soc.h             |    4 -
 3 files changed, 107 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index e1e7eeb..567ded7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -20,6 +20,7 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/host.h>
 #include <linux/of_platform.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/time.h>
 #include <asm/ipic.h>
@@ -39,6 +40,112 @@
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
+static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
+				   struct spi_board_info *board_infos,
+				   unsigned int num_board_infos,
+				   void (*cs_control)(struct spi_device *dev,
+						      bool on))
+{
+	struct device_node *np;
+	unsigned int i = 0;
+
+	for_each_compatible_node(np, type, compatible) {
+		int ret;
+		unsigned int j;
+		const void *prop;
+		struct resource res[2];
+		struct platform_device *pdev;
+		struct fsl_spi_platform_data pdata = {
+			.cs_control = cs_control,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		pdata.sysclk = sysclk;
+
+		prop = of_get_property(np, "reg", NULL);
+		if (!prop)
+			goto err;
+		pdata.bus_num = *(u32 *)prop;
+
+		prop = of_get_property(np, "cell-index", NULL);
+		if (prop)
+			i = *(u32 *)prop;
+
+		prop = of_get_property(np, "mode", NULL);
+		if (prop && !strcmp(prop, "cpu-qe"))
+			pdata.qe_mode = 1;
+
+		for (j = 0; j < num_board_infos; j++) {
+			if (board_infos[j].bus_num == pdata.bus_num)
+				pdata.max_chipselect++;
+		}
+
+		if (!pdata.max_chipselect)
+			continue;
+
+		ret = of_address_to_resource(np, 0, &res[0]);
+		if (ret)
+			goto err;
+
+		ret = of_irq_to_resource(np, 0, &res[1]);
+		if (ret == NO_IRQ)
+			goto err;
+
+		pdev = platform_device_alloc("mpc83xx_spi", i);
+		if (!pdev)
+			goto err;
+
+		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (ret)
+			goto unreg;
+
+		ret = platform_device_add_resources(pdev, res,
+						    ARRAY_SIZE(res));
+		if (ret)
+			goto unreg;
+
+		ret = platform_device_add(pdev);
+		if (ret)
+			goto unreg;
+
+		goto next;
+unreg:
+		platform_device_del(pdev);
+err:
+		pr_err("%s: registration failed\n", np->full_name);
+next:
+		i++;
+	}
+
+	return i;
+}
+
+static int __init fsl_spi_init(struct spi_board_info *board_infos,
+			       unsigned int num_board_infos,
+			       void (*cs_control)(struct spi_device *spi,
+						  bool on))
+{
+	u32 sysclk = -1;
+	int ret;
+
+	/* SPI controller is either clocked from QE or SoC clock */
+	sysclk = get_brgfreq();
+	if (sysclk == -1) {
+		sysclk = fsl_get_sys_freq();
+		if (sysclk == -1)
+			return -ENODEV;
+	}
+
+	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
+			       num_board_infos, cs_control);
+	if (!ret)
+		of_fsl_spi_probe("spi", "fsl_spi", sysclk, board_infos,
+				 num_board_infos, cs_control);
+
+	return spi_register_board_info(board_infos, num_board_infos);
+}
+
 static void mpc83xx_spi_cs_control(struct spi_device *spi, bool on)
 {
 	pr_debug("%s %d %d\n", __func__, spi->chip_select, on);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 0a545a9..18e49ef 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -413,113 +413,6 @@ err:
 
 arch_initcall(fsl_usb_of_init);
 
-static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
-				   struct spi_board_info *board_infos,
-				   unsigned int num_board_infos,
-				   void (*cs_control)(struct spi_device *dev,
-						      bool on))
-{
-	struct device_node *np;
-	unsigned int i = 0;
-
-	for_each_compatible_node(np, type, compatible) {
-		int ret;
-		unsigned int j;
-		const void *prop;
-		struct resource res[2];
-		struct platform_device *pdev;
-		struct fsl_spi_platform_data pdata = {
-			.cs_control = cs_control,
-		};
-
-		memset(res, 0, sizeof(res));
-
-		pdata.sysclk = sysclk;
-
-		prop = of_get_property(np, "reg", NULL);
-		if (!prop)
-			goto err;
-		pdata.bus_num = *(u32 *)prop;
-
-		prop = of_get_property(np, "cell-index", NULL);
-		if (prop)
-			i = *(u32 *)prop;
-
-		prop = of_get_property(np, "mode", NULL);
-		if (prop && !strcmp(prop, "cpu-qe"))
-			pdata.qe_mode = 1;
-
-		for (j = 0; j < num_board_infos; j++) {
-			if (board_infos[j].bus_num == pdata.bus_num)
-				pdata.max_chipselect++;
-		}
-
-		if (!pdata.max_chipselect)
-			continue;
-
-		ret = of_address_to_resource(np, 0, &res[0]);
-		if (ret)
-			goto err;
-
-		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
-			goto err;
-
-		pdev = platform_device_alloc("mpc83xx_spi", i);
-		if (!pdev)
-			goto err;
-
-		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
-		if (ret)
-			goto unreg;
-
-		ret = platform_device_add_resources(pdev, res,
-						    ARRAY_SIZE(res));
-		if (ret)
-			goto unreg;
-
-		ret = platform_device_add(pdev);
-		if (ret)
-			goto unreg;
-
-		goto next;
-unreg:
-		platform_device_del(pdev);
-err:
-		pr_err("%s: registration failed\n", np->full_name);
-next:
-		i++;
-	}
-
-	return i;
-}
-
-int __init fsl_spi_init(struct spi_board_info *board_infos,
-			unsigned int num_board_infos,
-			void (*cs_control)(struct spi_device *spi, bool on))
-{
-	u32 sysclk = -1;
-	int ret;
-
-#ifdef CONFIG_QUICC_ENGINE
-	/* SPI controller is either clocked from QE or SoC clock */
-	sysclk = get_brgfreq();
-#endif
-	if (sysclk == -1) {
-		sysclk = fsl_get_sys_freq();
-		if (sysclk == -1)
-			return -ENODEV;
-	}
-
-	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
-			       num_board_infos, cs_control);
-	if (!ret)
-		of_fsl_spi_probe("spi", "fsl_spi", sysclk, board_infos,
-				 num_board_infos, cs_control);
-
-	return spi_register_board_info(board_infos, num_board_infos);
-}
-
 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
 
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index b5f3456..42381bb 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -19,10 +19,6 @@ extern u32 fsl_get_sys_freq(void);
 struct spi_board_info;
 struct device_node;
 
-extern int fsl_spi_init(struct spi_board_info *board_infos,
-			unsigned int num_board_infos,
-			void (*cs_control)(struct spi_device *spi, bool on));
-
 extern void fsl_rstcr_restart(char *cmd);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-- 
1.5.6.5

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
