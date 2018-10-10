From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 2/2] dw: spi: add 'cs-override' DT property support
Date: Wed, 10 Oct 2018 10:08:13 +0300
Message-ID: <1539155293-21750-2-git-send-email-talel@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <talel@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for an optional devicetree property called 'cs-override', which
is necessary for the Amazon Alpine spi controller. 'cs-override' is used in
the dw spi driver if specified in the devicetree.  Otherwise, fall back to
driver default behavior, i.e., original dw IP hw driver behavior.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/spi/spi-dw-mmio.c | 2 ++
 drivers/spi/spi-dw.c      | 6 ++++++
 drivers/spi/spi-dw.h      | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a768461..a2f7359 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -195,6 +195,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 					goto out;
 			}
 		}
+		dws->cs_override = of_property_read_bool(pdev->dev.of_node,
+							 "cs-override");
 	}
 
 	init_func = device_get_match_data(&pdev->dev);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 3e205ab..eb4c3d1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,6 +144,8 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+	else
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
