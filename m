Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A447ECCD;
	Tue,  3 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555409; cv=none; b=SkeURJFUpoZyozQVno92Ekg5YoGkgSJdtjEJSaB5U3JSq8dhYncA2jOnBXVkkJ2B/uG2H73EvOmd+WlDbP8JGqEAoRFmq66OhQ7i8H5StuMqYhGON/5Jg8ApoLOiAiJgl765WCssThRA6XBdr3g9IvLV9Kx//EkubHCSZQ0twGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555409; c=relaxed/simple;
	bh=TbOHeK/mg1j4nM9RQJdsa7wWMdwNADEaugCoRnd5JV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+7IuxEQTPPIgqCiIog5aaRQMXFq4CS49UelBteuc3DBa+a4kpHsf7HG31GduCZheHY2ilFgSR6uU0By92/MP6ZKAswazjVjrvLy1iLYlxBmA5U6PDuouzLRtK3U+HBQzzdbvNWhY7AnGavdqwDF4SZrIisy1+987d2pSVlrKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=La7AI87e; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="La7AI87e"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uNHkFScFKLbXXB9ZwjM5ltQMNCVgdS4C7r79FlbEvY=;
	b=La7AI87ecgOu8O/+k2VAc9NRK2hZnZsq1JVHmj7hZoSUH95NG247PgJy2ySiuNxFZUmCYe
	kFAASFxOzCX0yNsmsrrIbgoZpntAUWIZbs8+/D1LxPeNDsycyY0Yo+gkil71TPGxWMb8Tx
	f4y1WsN4g0tvGcs/6hefIY7GriYoosj5x+ipJaNXj7NpJkUyMt/hJrEB7Hs8sxe2lwjx/D
	DLxcSCHdXj/xa2yKe4how+3cFqrE5Qge/XyC89+49S/GNqIHsoQIFUO2WFdy2qQ0+Jo15Q
	u9FwUU7F6Q2dGX+yvbYHLURwD14iWkz25V4oNA32l510mZ+4EM3j/R2U3GMbqQ==
Date: Tue, 03 Mar 2026 17:29:28 +0100
Subject: [PATCH RFC 7/7] spi: spi-fsl-qspi: Add support for RX data
 sampling point adjustment
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-7-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Han Xu <han.xu@nxp.com>
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, imx@lists.linux.dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5107;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=1Xfa4uE+iSkew2K7toE6BY8+v+eWmZiraSEE7IGgrhI=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T9ObmRvrL3mzrOYpOaxq/eb0/v2PmSJTZM6K+DMc+
 dra/eF3RykLgxgXg6yYIosUv8VrW7NYH/lj1VEwc1iZQIYwcHEKwETEAhgZDk7ac717Ea/JleyD
 J4yvJ3++ZXz+1u2fcbJTgnKll3DKuzP8L3pTvcl+wtWmt3z/015Xr0ideNdLtIdxYWzSmY09dg1
 BPAA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Eberhard Stoll <eberhard.stoll@kontron.de>

This QSPI controller supports shifting the RX data sampling point to
compensate line or SPI device response delays. This enables fast SPI
data transfers even for devices which have a significant delay in the
RX data stream.

Implement the set_rx_sampling_point() handler to:

1. check if the sampling point needs to be adjusted
2. prepare a value for the SDRSMP bits in the SMPR register and save it
3. reduce the clock rate if sampling point adjustment is not enough

During operation the SDRSMP bits in the SMPR register get updated
with the calculated value.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-fsl-qspi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index a223b4bc6e637..7021db144f84b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -88,6 +88,7 @@
 
 #define QUADSPI_SMPR			0x108
 #define QUADSPI_SMPR_DDRSMP_MASK	GENMASK(18, 16)
+#define QUADSPI_SMPR_SDRSMP(x)		((x) << 5)
 #define QUADSPI_SMPR_FSDLY_MASK		BIT(6)
 #define QUADSPI_SMPR_FSPHS_MASK		BIT(5)
 #define QUADSPI_SMPR_HSENA_MASK		BIT(0)
@@ -290,6 +291,16 @@ struct fsl_qspi {
 	struct device *dev;
 	int selected;
 	u32 memmap_phy;
+	u32 smpr;
+};
+
+#define RX_SAMPLING_MAX_DELAY_CYCLES			3
+#define RX_SAMPLING_DELAY_CYCLES_PER_CLOCK_CYCLE	2
+
+struct fsl_qspi_chip_data {
+	u8 sdrsmp;
+	u32 rx_sampling_delay_ns;
+	unsigned int rate;
 };
 
 static bool needs_swap_endian(struct fsl_qspi *q)
@@ -545,6 +556,27 @@ static void fsl_qspi_invalidate(struct fsl_qspi *q)
 	qspi_writel(q, reg, q->iobase + QUADSPI_MCR);
 }
 
+static void fsl_qspi_update_rx_sampling_delay(struct fsl_qspi *q, u32 sdrsmp)
+{
+	void __iomem *base = q->iobase;
+	u32 mcr, smpr = QUADSPI_SMPR_SDRSMP(sdrsmp);
+
+	/* skip if requested value matches cached value */
+	if (q->smpr == smpr)
+		return;
+
+	/* Disable the module */
+	mcr = qspi_readl(q, base + QUADSPI_MCR);
+	qspi_writel(q, mcr | QUADSPI_MCR_MDIS_MASK, base + QUADSPI_MCR);
+
+	qspi_writel(q, smpr, base + QUADSPI_SMPR);
+
+	/* Enable the module */
+	qspi_writel(q, mcr & ~QUADSPI_MCR_MDIS_MASK, base + QUADSPI_MCR);
+
+	q->smpr = smpr;
+}
+
 static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 				const struct spi_mem_op *op)
 {
@@ -668,6 +700,7 @@ static int fsl_qspi_readl_poll_tout(struct fsl_qspi *q, void __iomem *base,
 static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
+	struct fsl_qspi_chip_data *chip = spi_get_ctldata(mem->spi);
 	void __iomem *base = q->iobase;
 	u32 addr_offset = 0;
 	int err = 0;
@@ -679,6 +712,8 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	fsl_qspi_readl_poll_tout(q, base + QUADSPI_SR, (QUADSPI_SR_IP_ACC_MASK |
 				 QUADSPI_SR_AHB_ACC_MASK), 10, 1000);
 
+	fsl_qspi_update_rx_sampling_delay(q, chip->sdrsmp);
+
 	fsl_qspi_select_mem(q, mem->spi, op);
 
 	if (needs_amba_base_offset(q))
@@ -871,6 +906,28 @@ static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static int fsl_qspi_setup_device(struct spi_device *spi)
+{
+	struct fsl_qspi_chip_data *chip = spi_get_ctldata(spi);
+
+	if (!chip) {
+		chip = kzalloc_obj(*chip, GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+		spi_set_ctldata(spi, chip);
+	}
+
+	return 0;
+}
+
+static void fsl_qspi_cleanup_device(struct spi_device *spi)
+{
+	struct fsl_qspi_chip_data *chip = spi_get_ctldata(spi);
+
+	kfree(chip);
+	spi_set_ctldata(spi, NULL);
+}
+
 static void fsl_qspi_disable(void *data)
 {
 	struct fsl_qspi *q = data;
@@ -891,6 +948,25 @@ static void fsl_qspi_cleanup(void *data)
 	mutex_destroy(&q->lock);
 }
 
+static unsigned int fsl_qspi_set_rx_sampling_point(struct spi_device *spi, unsigned int freq)
+{
+	struct fsl_qspi_chip_data *chip = spi_get_ctldata(spi);
+
+	/* skip calculation if input clock rate and sampling delay did not change */
+	if (spi->rx_sampling_delay_ns == chip->rx_sampling_delay_ns &&
+	    freq == chip->rate)
+		return freq;
+
+	chip->rate = freq;
+	chip->rx_sampling_delay_ns = spi->rx_sampling_delay_ns;
+
+	chip->sdrsmp = spi_calc_rx_sampling_point(spi, &freq,
+						  RX_SAMPLING_MAX_DELAY_CYCLES,
+						  RX_SAMPLING_DELAY_CYCLES_PER_CLOCK_CYCLE);
+
+	return freq;
+}
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -915,6 +991,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, q);
 
+	ctlr->setup = fsl_qspi_setup_device;
+	ctlr->cleanup = fsl_qspi_cleanup_device;
+	ctlr->set_rx_sampling_point = fsl_qspi_set_rx_sampling_point;
+
 	/* find the resources */
 	q->iobase = devm_platform_ioremap_resource_byname(pdev, "QuadSPI");
 	if (IS_ERR(q->iobase))

-- 
2.53.0

