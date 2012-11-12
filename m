From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/17] spi/atmel_spi: add function to read the spi data from
	the dts
Date: Mon, 12 Nov 2012 16:52:33 +0800
Message-ID: <1352710357-3265-14-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The spi data include: dma_type and version.
dma_type to decide the SPI xfer mode: = 1(pdc), = 2(dmaengine), 0(no dma, using PIO)
version to give the SPI ip version.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 .../devicetree/bindings/spi/spi_atmel.txt          |    4 +++
 drivers/spi/spi-atmel.c                            |   28 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 20cdc91..a1ceeb5 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -6,6 +6,8 @@ Required properties:
 - interrupts: Should contain macb interrupt
 - cs-gpio: Should contain the GPIOs used for chipselect.
 - dma-mask: device coherent dma mask.
+- dma_type: The dma type supported by the spi of SoC: = 0 (no used), = 1 (pdc), = 2 (dma)
+- version: The version of the spi IP.
 
 spi0: spi@f0000000 {
 	#address-cells = <1>;
@@ -19,5 +21,7 @@ spi0: spi@f0000000 {
 		    &pioB 3 0 /* conflicts with ERXDV */
 		   >;
 	dma-mask = <0xffffffff>;
+	dma_type = <1>;
+	version = <2>;
 	status = "disabled";
 };
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 568df5b..791800e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1467,6 +1467,30 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 	kfree(asd);
 }
 
+static int of_get_atmel_spi_data(struct device_node *np, struct atmel_spi *as)
+{
+	const __be32	*val;
+
+	val = of_get_property(np, "dma_type", NULL);
+	if (!val) {
+		pr_err("%s: have no 'dma_type' property\n",
+						np->full_name);
+		return -EINVAL;
+	}
+
+	as->data.dma_type = be32_to_cpup(val);
+
+	val = of_get_property(np, "version", NULL);
+	if (!val) {
+		pr_err("%s: have no 'version' property\n", np->full_name);
+		return -EINVAL;
+	}
+
+	as->data.version = be32_to_cpup(val);
+
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 
 static int __devinit atmel_spi_probe(struct platform_device *pdev)
@@ -1535,6 +1559,10 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unmap_regs;
 
+	ret = of_get_atmel_spi_data(pdev->dev.of_node, as);
+	if (ret)
+		goto out_unmap_regs;
+
 	/* Initialize the hardware */
 	clk_enable(clk);
 	spi_writel(as, CR, SPI_BIT(SWRST));
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
