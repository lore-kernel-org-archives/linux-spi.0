From: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 5/6] ARM i.MX: rename ssi1 clock for imx27
Date: Fri,  9 Nov 2012 15:00:24 +0100
Message-ID: <1352469625-32024-6-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 arch/arm/mach-imx/clk-imx27.c |    2 +-
 arch/arm/mach-imx/imx27-dt.c  |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 366e5d5..d269532 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -236,7 +236,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
+	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "10010000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[nfc_baud_gate], NULL, "mxc_nand.0");
 	clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index e80d523..60eed17 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -29,6 +29,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "mxc_nand.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx21-ssi", MX27_SSI1_BASE_ADDR, "10010000.ssi", NULL),
 	{ /* sentinel */ }
 };
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
