From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Allow interface drivers to limit data I/O to word sizes" to the spi tree
Date: Fri, 21 Aug 2015 10:26:03 -0700
Message-ID: <E1ZSq4p-0005VX-2Q@finisterre>
References: <1439929313-4948-3-git-send-email-michael@smart-africa.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439929313-4948-3-git-send-email-michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Allow interface drivers to limit data I/O to word sizes

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

>From c4fe57f76269dbb2af135071513f260ca40229a3 Mon Sep 17 00:00:00 2001
From: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Date: Tue, 18 Aug 2015 22:21:53 +0200
Subject: [PATCH] spi: dw: Allow interface drivers to limit data I/O to word
 sizes

The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit
accesses") changed all 16bit accesses in the DW_apb_ssi driver to 32bit.
This, unfortunately, breaks data register access on picoXcell, where the
DW IP needs data register accesses to be word accesses (all other
accesses appear to be OK).

This change introduces a new master variable to allow interface drivers
to specify that 16bit data transfer I/O is required.  This change also
introduces the ability to set this variable via device tree bindings in
the MMIO interface driver.  Both the core and the MMIO interface driver
default to the current 32bit behaviour.

Before this change, on a picoXcell pc3x3:
 spi_master spi32766: interrupt_transfer: fifo overrun/underrun
 m25p80 spi32766.0: error -5 reading 9f
 m25p80: probe of spi32766.0 failed with error -5

After this change:
 m25p80 spi32766.0: m25p40 (512 Kbytes)

Fixes: dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit accesses")
Signed-off-by: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c |  3 +++
 drivers/spi/spi-dw.c      |  4 ++--
 drivers/spi/spi-dw.h      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index eb03e12..7edede6 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -74,6 +74,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
+	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
+			     &dws->reg_io_width);
+
 	num_cs = 4;
 
 	if (pdev->dev.of_node)
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 8d67d03..4fbfcdc 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -194,7 +194,7 @@ static void dw_writer(struct dw_spi *dws)
 			else
 				txw = *(u16 *)(dws->tx);
 		}
-		dw_writel(dws, DW_SPI_DR, txw);
+		dw_write_io_reg(dws, DW_SPI_DR, txw);
 		dws->tx += dws->n_bytes;
 	}
 }
@@ -205,7 +205,7 @@ static void dw_reader(struct dw_spi *dws)
 	u16 rxw;
 
 	while (max--) {
-		rxw = dw_readl(dws, DW_SPI_DR);
+		rxw = dw_read_io_reg(dws, DW_SPI_DR);
 		/* Care rx only if the transfer's original "rx" is not null */
 		if (dws->rx_end - dws->len) {
 			if (dws->n_bytes == 1)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 6c91391..b75ed32 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -109,6 +109,7 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
+	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 
@@ -145,11 +146,45 @@ static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
 	return __raw_readl(dws->regs + offset);
 }
 
+static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
+{
+	return __raw_readw(dws->regs + offset);
+}
+
 static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 {
 	__raw_writel(val, dws->regs + offset);
 }
 
+static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
+{
+	__raw_writew(val, dws->regs + offset);
+}
+
+static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
+{
+	switch (dws->reg_io_width) {
+	case 2:
+		return dw_readw(dws, offset);
+	case 4:
+	default:
+		return dw_readl(dws, offset);
+	}
+}
+
+static inline void dw_write_io_reg(struct dw_spi *dws, u32 offset, u32 val)
+{
+	switch (dws->reg_io_width) {
+	case 2:
+		dw_writew(dws, offset, val);
+		break;
+	case 4:
+	default:
+		dw_writel(dws, offset, val);
+		break;
+	}
+}
+
 static inline void spi_enable_chip(struct dw_spi *dws, int enable)
 {
 	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
