From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 5/6] spi/bcm63xx: move register definitions into the driver
Date: Thu, 10 Sep 2015 16:11:43 +0200
Message-ID: <1441894304-22316-6-git-send-email-jogo@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move all register definitions and structs into the driver. This allows
us dropping the platform_data struct and drop any arch specific
includes.

Since we now have full control over the message width, we can drop the
size check, which was broken anyway, since it never set ret to any error
code.

Also since we now have no arch depedendent resources, we can now allow
compiling it for any arch, hidding behind COMPILE_TEST.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/Kconfig       |   2 +-
 drivers/spi/spi-bcm63xx.c | 176 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 158 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4887f31..5c1db98 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -125,7 +125,7 @@ config SPI_BCM53XX
 
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
-	depends on BCM63XX
+	depends on BCM63XX || COMPILE_TEST
 	help
           Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index ef05387..6353607 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -27,7 +27,108 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 
-#include <bcm63xx_dev_spi.h>
+/* BCM 6338/6348 SPI core */
+#define SPI_6348_RSET_SIZE		64
+#define SPI_6348_CMD			0x00	/* 16-bits register */
+#define SPI_6348_INT_STATUS		0x02
+#define SPI_6348_INT_MASK_ST		0x03
+#define SPI_6348_INT_MASK		0x04
+#define SPI_6348_ST			0x05
+#define SPI_6348_CLK_CFG		0x06
+#define SPI_6348_FILL_BYTE		0x07
+#define SPI_6348_MSG_TAIL		0x09
+#define SPI_6348_RX_TAIL		0x0b
+#define SPI_6348_MSG_CTL		0x40	/* 8-bits register */
+#define SPI_6348_MSG_CTL_WIDTH		8
+#define SPI_6348_MSG_DATA		0x41
+#define SPI_6348_MSG_DATA_SIZE		0x3f
+#define SPI_6348_RX_DATA		0x80
+#define SPI_6348_RX_DATA_SIZE		0x3f
+
+/* BCM 3368/6358/6262/6368 SPI core */
+#define SPI_6358_RSET_SIZE		1804
+#define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
+#define SPI_6358_MSG_CTL_WIDTH		16
+#define SPI_6358_MSG_DATA		0x02
+#define SPI_6358_MSG_DATA_SIZE		0x21e
+#define SPI_6358_RX_DATA		0x400
+#define SPI_6358_RX_DATA_SIZE		0x220
+#define SPI_6358_CMD			0x700	/* 16-bits register */
+#define SPI_6358_INT_STATUS		0x702
+#define SPI_6358_INT_MASK_ST		0x703
+#define SPI_6358_INT_MASK		0x704
+#define SPI_6358_ST			0x705
+#define SPI_6358_CLK_CFG		0x706
+#define SPI_6358_FILL_BYTE		0x707
+#define SPI_6358_MSG_TAIL		0x709
+#define SPI_6358_RX_TAIL		0x70B
+
+/* Shared SPI definitions */
+
+/* Message configuration */
+#define SPI_FD_RW			0x00
+#define SPI_HD_W			0x01
+#define SPI_HD_R			0x02
+#define SPI_BYTE_CNT_SHIFT		0
+#define SPI_6348_MSG_TYPE_SHIFT		6
+#define SPI_6358_MSG_TYPE_SHIFT		14
+
+/* Command */
+#define SPI_CMD_NOOP			0x00
+#define SPI_CMD_SOFT_RESET		0x01
+#define SPI_CMD_HARD_RESET		0x02
+#define SPI_CMD_START_IMMEDIATE		0x03
+#define SPI_CMD_COMMAND_SHIFT		0
+#define SPI_CMD_COMMAND_MASK		0x000f
+#define SPI_CMD_DEVICE_ID_SHIFT		4
+#define SPI_CMD_PREPEND_BYTE_CNT_SHIFT	8
+#define SPI_CMD_ONE_BYTE_SHIFT		11
+#define SPI_CMD_ONE_WIRE_SHIFT		12
+#define SPI_DEV_ID_0			0
+#define SPI_DEV_ID_1			1
+#define SPI_DEV_ID_2			2
+#define SPI_DEV_ID_3			3
+
+/* Interrupt mask */
+#define SPI_INTR_CMD_DONE		0x01
+#define SPI_INTR_RX_OVERFLOW		0x02
+#define SPI_INTR_TX_UNDERFLOW		0x04
+#define SPI_INTR_TX_OVERFLOW		0x08
+#define SPI_INTR_RX_UNDERFLOW		0x10
+#define SPI_INTR_CLEAR_ALL		0x1f
+
+/* Status */
+#define SPI_RX_EMPTY			0x02
+#define SPI_CMD_BUSY			0x04
+#define SPI_SERIAL_BUSY			0x08
+
+/* Clock configuration */
+#define SPI_CLK_20MHZ			0x00
+#define SPI_CLK_0_391MHZ		0x01
+#define SPI_CLK_0_781MHZ		0x02	/* default */
+#define SPI_CLK_1_563MHZ		0x03
+#define SPI_CLK_3_125MHZ		0x04
+#define SPI_CLK_6_250MHZ		0x05
+#define SPI_CLK_12_50MHZ		0x06
+#define SPI_CLK_MASK			0x07
+#define SPI_SSOFFTIME_MASK		0x38
+#define SPI_SSOFFTIME_SHIFT		3
+#define SPI_BYTE_SWAP			0x80
+
+enum bcm63xx_regs_spi {
+	SPI_CMD,
+	SPI_INT_STATUS,
+	SPI_INT_MASK_ST,
+	SPI_INT_MASK,
+	SPI_ST,
+	SPI_CLK_CFG,
+	SPI_FILL_BYTE,
+	SPI_MSG_TAIL,
+	SPI_RX_TAIL,
+	SPI_MSG_CTL,
+	SPI_MSG_DATA,
+	SPI_RX_DATA,
+};
 
 #define BCM63XX_SPI_MAX_PREPEND		15
 
@@ -41,6 +142,7 @@ struct bcm63xx_spi {
 	int			irq;
 
 	/* Platform data */
+	const unsigned long	*reg_offsets;
 	unsigned		fifo_size;
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
@@ -54,34 +156,34 @@ struct bcm63xx_spi {
 };
 
 static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
-				unsigned int offset)
+			       unsigned int offset)
 {
-	return readb(bs->regs + bcm63xx_spireg(offset));
+	return readb(bs->regs + bs->reg_offsets[offset]);
 }
 
 static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
 #ifdef CONFIG_BIG_ENDIAN
-	return ioread16(bs->regs + bcm63xx_spireg(offset));
+	return ioread16(bs->regs + bs->reg_offsets[offset]);
 #else
-	return readw(bs->regs + bcm63xx_spireg(offset));
+	return readw(bs->regs + bs->reg_offsets[offset]);
 #endif
 }
 
 static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
 				  u8 value, unsigned int offset)
 {
-	writeb(value, bs->regs + bcm63xx_spireg(offset));
+	writeb(value, bs->regs + bs->reg_offsets[offset]);
 }
 
 static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 				  u16 value, unsigned int offset)
 {
 #ifdef CONFIG_BIG_ENDIAN
-	iowrite16(value, bs->regs + bcm63xx_spireg(offset));
+	iowrite16(value, bs->regs + bs->reg_offsets[offset]);
 #else
-	writew(value, bs->regs + bcm63xx_spireg(offset));
+	writew(value, bs->regs + bs->reg_offsets[offset]);
 #endif
 }
 
@@ -324,12 +426,40 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static const unsigned long bcm6348_spi_reg_offsets[] = {
+	[SPI_CMD]		= SPI_6348_CMD,
+	[SPI_INT_STATUS]	= SPI_6348_INT_STATUS,
+	[SPI_INT_MASK_ST]	= SPI_6348_INT_MASK_ST,
+	[SPI_INT_MASK]		= SPI_6348_INT_MASK,
+	[SPI_ST]		= SPI_6348_ST,
+	[SPI_CLK_CFG]		= SPI_6348_CLK_CFG,
+	[SPI_FILL_BYTE]		= SPI_6348_FILL_BYTE,
+	[SPI_MSG_TAIL]		= SPI_6348_MSG_TAIL,
+	[SPI_RX_TAIL]		= SPI_6348_RX_TAIL,
+	[SPI_MSG_CTL]		= SPI_6348_MSG_CTL,
+	[SPI_MSG_DATA]		= SPI_6348_MSG_DATA,
+	[SPI_RX_DATA]		= SPI_6348_RX_DATA,
+};
+
+static const unsigned long bcm6358_spi_reg_offsets[] = {
+	[SPI_CMD]		= SPI_6358_CMD,
+	[SPI_INT_STATUS]	= SPI_6358_INT_STATUS,
+	[SPI_INT_MASK_ST]	= SPI_6358_INT_MASK_ST,
+	[SPI_INT_MASK]		= SPI_6358_INT_MASK,
+	[SPI_ST]		= SPI_6358_ST,
+	[SPI_CLK_CFG]		= SPI_6358_CLK_CFG,
+	[SPI_FILL_BYTE]		= SPI_6358_FILL_BYTE,
+	[SPI_MSG_TAIL]		= SPI_6358_MSG_TAIL,
+	[SPI_RX_TAIL]		= SPI_6358_RX_TAIL,
+	[SPI_MSG_CTL]		= SPI_6358_MSG_CTL,
+	[SPI_MSG_DATA]		= SPI_6358_MSG_DATA,
+	[SPI_RX_DATA]		= SPI_6358_RX_DATA,
+};
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	struct device *dev = &pdev->dev;
-	struct bcm63xx_spi_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int irq;
 	struct spi_master *master;
 	struct clk *clk;
@@ -369,7 +499,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bs->irq = irq;
 	bs->clk = clk;
-	bs->fifo_size = pdata->fifo_size;
 
 	ret = devm_request_irq(&pdev->dev, irq, bcm63xx_spi_interrupt, 0,
 							pdev->name, master);
@@ -384,21 +513,30 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->auto_runtime_pm = true;
-	bs->msg_type_shift = pdata->msg_type_shift;
-	bs->msg_ctl_width = pdata->msg_ctl_width;
-	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
-	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
 
-	switch (bs->msg_ctl_width) {
-	case 8:
-	case 16:
+	switch (resource_size(r)) {
+	case SPI_6348_RSET_SIZE:
+		bs->reg_offsets = bcm6348_spi_reg_offsets;
+		bs->msg_type_shift = SPI_6348_MSG_TYPE_SHIFT;
+		bs->msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
+		bs->fifo_size = SPI_6348_MSG_DATA_SIZE;
+		break;
+	case SPI_6358_RSET_SIZE:
+		bs->reg_offsets = bcm6358_spi_reg_offsets;
+		bs->msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
+		bs->msg_ctl_width = SPI_6358_MSG_CTL_WIDTH;
+		bs->fifo_size = SPI_6358_MSG_DATA_SIZE;
 		break;
 	default:
-		dev_err(dev, "unsupported MSG_CTL width: %d\n",
-			 bs->msg_ctl_width);
+		ret = -EINVAL;
+		dev_err(dev, "unsupported register size: %i\n",
+			resource_size(r));
 		goto out_err;
 	}
 
+	bs->tx_io = (u8 *)(bs->regs + bs->reg_offsets[SPI_MSG_DATA]);
+	bs->rx_io = (const u8 *)(bs->regs + bs->reg_offsets[SPI_RX_DATA]);
+
 	/* Initialize hardware */
 	ret = clk_prepare_enable(bs->clk);
 	if (ret)
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
