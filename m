From: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] spi/rockchip: Add device tree property to configure Rx Sample Delay
Date: Thu, 26 Mar 2015 16:30:25 -0700
Message-ID: <1427412625-12377-2-git-send-email-jwerner@chromium.org>
References: <1427412625-12377-1-git-send-email-jwerner@chromium.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427412625-12377-1-git-send-email-jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We have found that we can sometimes see read failures on boards with
high-capacitance SPI lines. It seems that the controller samples the Rx
data line too early, and its register interface has an "Rx Sample Delay"
setting to fine-tune against this issue.

This patch adds a new optional device tree entry that can configure this
delay in terms of nanoseconds. The kernel will calculate the
best-fitting amount of parent clock ticks to program the controller with
based on that.

Signed-off-by: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-rockchip.txt        |  4 ++++
 drivers/spi/spi-rockchip.c                          | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 467dec4..0c491bd 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -24,6 +24,9 @@ Optional Properties:
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
+- rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
+		Rx data (may need to be fine tuned for high capacitance lines).
+		No delay (0) by default.
 
 
 Example:
@@ -33,6 +36,7 @@ Example:
 		reg = <0xff110000 0x1000>;
 		dmas = <&pdma1 11>, <&pdma1 12>;
 		dma-names = "tx", "rx";
+		rx-sample-delay-ns = <10>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5e4e52c..f89cd5d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -179,6 +179,7 @@ struct rockchip_spi {
 	u8 tmode;
 	u8 bpw;
 	u8 n_bytes;
+	u8 rsd_nsecs;
 	unsigned len;
 	u32 speed;
 
@@ -493,6 +494,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
+	int rsd = 0;
 
 	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
 		| (CR0_SSD_ONE << CR0_SSD_OFFSET);
@@ -522,6 +524,20 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
 	div = (div + 1) & 0xfffe;
 
+	/* Rx sample delay is expressed in parent clock cycles (max 3) */
+	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->max_freq >> 8),
+				1000000000 >> 8);
+	if (!rsd && rs->rsd_nsecs) {
+		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
+			     rs->max_freq, rs->rsd_nsecs);
+	} else if (rsd > 3) {
+		rsd = 3;
+		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+			     rs->max_freq, rs->rsd_nsecs,
+			     rsd * 1000000000U / rs->max_freq);
+	}
+	cr0 |= rsd << CR0_RSD_OFFSET;
+
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
@@ -614,6 +630,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	struct rockchip_spi *rs;
 	struct spi_master *master;
 	struct resource *mem;
+	u32 rsd_nsecs;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct rockchip_spi));
 	if (!master)
@@ -665,6 +682,10 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
 
+	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
+				  &rsd_nsecs))
+		rs->rsd_nsecs = rsd_nsecs;
+
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
