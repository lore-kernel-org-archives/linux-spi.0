From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi-imx: Implements handling of the SPI_READY mode flag." to the spi tree
Date: Tue, 25 Apr 2017 16:46:25 +0100
Message-ID: <E1d32fZ-000247-9G@debutante>
References: <20170423191958.32724-1-Leif.Middelschulte@gmail.com>
Cc: Leif Middelschulte <Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170423191958.32724-1-Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi-imx: Implements handling of the SPI_READY mode flag.

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f72efa7e690ab5c4068ccba31c4da032bc45c29c Mon Sep 17 00:00:00 2001
From: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 23 Apr 2017 21:19:58 +0200
Subject: [PATCH] spi-imx: Implements handling of the SPI_READY mode flag.

This patch implements consideration of the SPI_READY mode flag as
defined in spi.h. It extends the device tree bindings to support
the values defined by the reference manual for the DRCTL field.

Thus supporting edge-triggered and level-triggered bursts.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt         |  7 +++++++
 drivers/spi/spi-imx.c                                | 20 ++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 8bc95e2fc47f..31b5b21598ff 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -23,6 +23,12 @@ See the clock consumer binding,
 Obsolete properties:
 - fsl,spi-num-chipselects : Contains the number of the chipselect
 
+Optional properties:
+- fsl,spi-rdy-drctl: Integer, representing the value of DRCTL, the register
+controlling the SPI_READY handling. Note that to enable the DRCTL consideration,
+the SPI_READY mode-flag needs to be set too.
+Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
+
 Example:
 
 ecspi@70010000 {
@@ -35,4 +41,5 @@ ecspi@70010000 {
 		   <&gpio3 25 0>; /* GPIO3_25 */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 	dma-names = "rx", "tx";
+	fsl,spi-rdy-drctl = <1>;
 };
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a7c62f471dc..b402530a7a9a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -95,6 +95,7 @@ struct spi_imx_data {
 	unsigned int spi_bus_clk;
 
 	unsigned int bytes_per_word;
+	unsigned int spi_drctl;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -246,6 +247,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
 #define MX51_ECSPI_CTRL_SMC		(1 << 3)
 #define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
+#define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
@@ -355,6 +357,12 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	 */
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
+	/*
+	 * Enable SPI_RDY handling (falling edge/level triggered).
+	 */
+	if (spi->mode & SPI_READY)
+		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
+
 	/* set clock speed */
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
@@ -1173,7 +1181,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, irq;
+	int i, ret, irq, spi_drctl;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -1181,6 +1189,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
+	ret = of_property_read_u32(np, "fsl,spi-rdy-drctl", &spi_drctl);
+	if ((ret < 0) || (spi_drctl >= 0x3)) {
+		/* '11' is reserved */
+		spi_drctl = 0;
+	}
+
 	if (!master)
 		return -ENOMEM;
 
@@ -1216,7 +1230,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
-		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
+		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
+
+	spi_imx->spi_drctl = spi_drctl;
 
 	init_completion(&spi_imx->xfer_done);
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
