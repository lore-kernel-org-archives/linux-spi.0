From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 2/2] dw: spi: add support for Amazon's Alpine spi controller
Date: Thu, 11 Oct 2018 14:20:07 +0300
Message-ID: <1539256807-25676-2-git-send-email-talel@amazon.com>
References: <1539209339.1944.23.camel@impinj.com>
 <1539256807-25676-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <talel@amazon.com>, <jonnyc@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539256807-25676-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for a new devicetree compatible string called
'amazon,alpine-apb-ssi', which is necessary for the Amazon Alpine spi
controller. 'amazon,alpine-dw-apb-ssi' is used in the dw spi driver if
specified in the devicetree.  Otherwise, fall back to driver default
behavior, i.e. original dw IP hw driver behavior.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++++++
 drivers/spi/spi-dw.c      | 6 ++++++
 drivers/spi/spi-dw.h      | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a768461..3ffb6a40 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -126,6 +126,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 				JAGUAR2_IF_SI_OWNER_OFFSET);
 }
 
+static int dw_spi_alpine_init(struct platform_device *pdev,
+			      struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.cs_override = 1;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -230,6 +238,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
+	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 3e205ab..b705f2b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,6 +144,8 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+	else if (dws->cs_override)
+		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
@@ -463,6 +465,10 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->fifo_len = (fifo == 1) ? 0 : fifo;
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
+
+	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
+	if (dws->cs_override)
+		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 0168b08..c9c1588 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,6 +32,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
@@ -109,6 +110,7 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
+	int			cs_override;
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
-- 
2.7.4
