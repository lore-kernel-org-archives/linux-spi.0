From: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi-imx: Implements handling of the SPI_READY mode flag.
Date: Thu, 20 Apr 2017 18:53:22 +0200
Message-ID: <20170420165322.4356-1-Leif.Middelschulte@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch implements consideration of the SPI_READY mode flag as
defined in spi.h. It extends the device tree bindings to support
the values defined by the reference manual for the DRCTL field.

Thus supporting edge-triggered and level-triggered bursts.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  5 +++++
 drivers/spi/spi-imx.c                              | 24 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 523341a0e113..52336558a121 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -21,6 +21,10 @@ See the clock consumer binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
 
+Optional properties:
+- fsl,spi-drctl: Integer, representing the value of DRCTL. Note that to
+enable the DRCTL consideration, the SPI_READY mode-flag needs to be set.
+
 Example:
 
 ecspi@70010000 {
@@ -34,4 +38,5 @@ ecspi@70010000 {
 		   <&gpio3 25 0>; /* GPIO3_25 */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 	dma-names = "rx", "tx";
+	fsl,spi-drctl = <1>;
 };
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f0b10219ee63..95f22dd7aa8b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -92,6 +92,7 @@ struct spi_imx_data {
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
+	unsigned int spi_drctl;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -213,6 +214,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
 #define MX51_ECSPI_CTRL_SMC		(1 << 3)
 #define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
+#define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
@@ -324,6 +326,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 */
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
+	/*
+	 * Enable SPI_RDY handling (falling edge/level triggered).
+	 */
+	if (config->mode & SPI_READY)
+		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
+
 	/* set clock speed */
 	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
 
@@ -1089,13 +1097,22 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs, irq;
+	int i, ret, num_cs, irq, spi_drctl;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
 	}
 
+	ret = of_property_read_u32(np, "fsl,spi-drctl", &spi_drctl);
+	if ((ret < 0) || (spi_drctl == 0x3)) {
+		// '11' is reserved
+		spi_drctl = 0;
+	} else {
+		// only the values '00', '01' and '11' are valid
+		spi_drctl &= 0x3;
+	}
+
 	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
 	if (ret < 0) {
 		if (mxc_platform_info)
@@ -1142,7 +1159,10 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
-	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
+					   | SPI_READY;
+
+	spi_imx->spi_drctl = spi_drctl;
 
 	init_completion(&spi_imx->xfer_done);
 
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
