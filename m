From: xiaolei li <xiaolei.li@mediatek.com>
Subject: Re: [PATCH v2 1/3] spi: spi-mem: MediaTek: Add SPI NAND Flash
 interface driver for MT7622
Date: Tue, 25 Dec 2018 16:38:06 +0800
Message-ID: <1545727086.7353.29.camel@mhfsdcap03>
References: <1545715410-22954-1-git-send-email-xiangsheng.hou@mediatek.com>
 <1545715410-22954-2-git-send-email-xiangsheng.hou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ryder.lee@mediatek.com, guochun.mao@mediatek.com,
 srv_heupstream@mediatek.com, marek.vasut@gmail.com, weijie.gao@mediatek.com,
 bayi.cheng@mediatek.com, linux-spi@vger.kernel.org,
 boris.brezillon@bootlin.com, tzu-ting.tseng@mediatek.com,
 linux-mtd@lists.infradead.org, honghui.zhang@mediatek.com,
 benliang.zhao@mediatek.com
To: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1545715410-22954-2-git-send-email-xiangsheng.hou@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Xiangsheng,

On Tue, 2018-12-25 at 13:23 +0800, Xiangsheng Hou wrote:
> - Add a driver for MediaTek SPI Nand interface for MediaTek MT7622
> 
> (0) What is the MediaTek SPI Nand interface?
> SPI Nand interface is a part of the MediaTek Nand controller which can
> support Parallel Nand and SPI Nand via Parallel Nand or SPI interface.
> Furthermore,they are alternative on the MediaTek Nand controller.
> This patch use spi-mem and spi-nand framework to operate device with
> SPI Nand.This driver may can support SPI Nor and other SPI device,
> but we just test with SPI Nand device.
> 
> (1) DMA read/write access by AHB Bus
> 
> (2) Tested this driver with mtd_test utlity and JFFS2 filesystem on
>  Mediatek MT7622
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
> Changes for v2:
> - Remove dependency of driver over mtd and spinand_device information
> - Use controller customizes size for sector
> - Just use 1 bit data mode
> ---
>  drivers/spi/Kconfig        |    9 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-mtk-snfi.c |  682 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 692 insertions(+)
>  create mode 100644 drivers/spi/spi-mtk-snfi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7d3a5c9..df424ac 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -397,6 +397,15 @@ config SPI_MT65XX
>  	  say Y or M here.If you are not sure, say N.
>  	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
>  
> +config SPI_MTK_SNFI
> +	tristate "MediaTek SPI NAND interface"
> +	select MTD_SPI_NAND
> +	help
> +	  This selects the SPI NAND FLASH interface(SNFI),
> +	  which could be found on MediaTek Soc.
> +	  Say Y or M here.If you are not sure, say N.
> +	  Note Parallel Nand and SPI NAND is alternative on MediaTek SoCs.
> +
>  config SPI_NUC900
>  	tristate "Nuvoton NUC900 series SPI"
>  	depends on ARCH_W90X900
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 3575205..1493c17 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
>  obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
>  obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
> +obj-$(CONFIG_SPI_MTK_SNFI)		+= spi-mtk-snfi.o
>  obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
>  obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
>  obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
> diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> new file mode 100644
> index 0000000..37e777c
> --- /dev/null
> +++ b/drivers/spi/spi-mtk-snfi.c
> @@ -0,0 +1,682 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for MediaTek SPI Nand interface
> + *
> + * Copyright (C) 2018 MediaTek Inc.
> + * Authors:	Xiangsheng Hou	<xiangsheng.hou@mediatek.com>
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* Registers used by the driver */
> +#define NFI_CNFG		0x00
> +#define		CNFG_DMA		BIT(0)
> +#define		CNFG_READ_EN		BIT(1)
> +#define		CNFG_DMA_BURST_EN	BIT(2)
> +#define		CNFG_OP_PROGRAM		GENMASK(13, 12)
> +#define		CNFG_OP_CUST		GENMASK(14, 13)
> +#define NFI_CON			0x08
> +#define		CON_FIFO_FLUSH		BIT(0)
> +#define		CON_NFI_RST		BIT(1)
> +#define		CON_BRD			BIT(8)
> +#define		CON_BWR			BIT(9)
> +#define		CON_SEC_SHIFT		12
> +#define NFI_INTR_EN		0x10
> +#define		INTR_AHB_DONE_EN	BIT(6)
> +#define NFI_INTR_STA		0x14
> +#define NFI_CMD			0x20
> +#define NFI_STA			0x60
> +#define		NFI_FSM_MASK		GENMASK(19, 16)
> +#define NFI_ADDRCNTR		0x70
> +#define		CNTR_MASK		GENMASK(16, 12)
> +#define		ADDRCNTR_SEC_SHIFT	12
> +#define		ADDRCNTR_SEC(val) \
> +		(((val) & CNTR_MASK) >> ADDRCNTR_SEC_SHIFT)
> +#define NFI_STRADDR		0x80
> +#define NFI_BYTELEN		0x84
> +#define NFI_SECCUS_SIZE		0x22c
> +#define		SECUS_SIZE_EN		BIT(16)
> +#define		SECUS_SIZE_MASK		GENMASK(12, 0)
> +#define		SECUS_MAX_SIZE		8187
> +#define SNFI_MAC_OUTL		0x504
> +#define SNFI_MAC_INL		0x508
> +#define SNFI_RD_CTL2		0x510
> +#define		RD_CMD_MASK		0x00ff
> +#define		RD_DUMMY_SHIFT		8
> +#define SNFI_RD_CTL3		0x514
> +#define		RD_ADDR_MASK		0xffff
> +#define SNFI_MISC_CTL		0x538
> +#define		RD_MODE_MASK		GENMASK(18, 16)
> +#define		RD_CUSTOM_EN		BIT(6)
> +#define		WR_CUSTOM_EN		BIT(7)
> +#define		WR_X4_EN		BIT(20)
> +#define		SW_RST			BIT(28)
> +#define SNFI_MISC_CTL2		0x53c
> +#define		WR_LEN_SHIFT		16
> +#define SNFI_PG_CTL1		0x524
> +#define		WR_LOAD_CMD_SHIFT	8
> +#define SNFI_PG_CTL2		0x528
> +#define		WR_LOAD_ADDR_MASK	GENMASK(15, 0)
> +#define SNFI_MAC_CTL		0x500
> +#define		MAC_WIP			BIT(0)
> +#define		MAC_WIP_READY		BIT(1)
> +#define		MAC_TRIG		BIT(2)
> +#define		MAC_EN			BIT(3)
> +#define		MAC_SIO_SEL		BIT(4)
> +#define SNFI_STA_CTL1		0x550
> +#define		SPI_STATE		GENMASK(3, 0)
> +#define SNFI_CNFG		0x55c
> +#define		SNFI_MODE_EN		BIT(0)
> +#define SNFI_GPRAM_DATA		0x800
> +#define		SNFI_GPRAM_MAX_LEN	160
> +
> +/* Dummy command trigger NFI to spi mode */
> +#define NAND_CMD_DUMMYREAD	0x00
> +#define NAND_CMD_DUMMYPROG	0x80
> +
> +#define MTK_TIMEOUT		500000
> +#define MTK_RESET_TIMEOUT	1000000
> +
> +struct mtk_snfi {
> +	struct clk *nfi_clk;
> +	struct clk *spi_clk;
> +	struct completion done;
> +	struct device *dev;
> +
> +	void __iomem *regs;
> +};
> +
> +static void mtk_snfi_mac_enable(struct mtk_snfi *snfi)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MAC_CTL);
> +	reg &= ~MAC_SIO_SEL;
> +	reg |= MAC_EN;
> +
> +	writel(reg, snfi->regs + SNFI_MAC_CTL);
> +}
> +
> +static int mtk_snfi_mac_trigger(struct mtk_snfi *snfi)
> +{
> +	u32 reg;
> +	int ret = 0;
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MAC_CTL);
> +	reg |= MAC_TRIG;
> +	writel(reg, snfi->regs + SNFI_MAC_CTL);
> +
> +	ret = readl_poll_timeout_atomic(snfi->regs + SNFI_MAC_CTL, reg,
> +					reg & MAC_WIP_READY, 10,
> +					MTK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(snfi->dev, "polling wip ready for read timeout\n");
> +		return -EIO;
> +	}
> +
> +	ret = readl_poll_timeout_atomic(snfi->regs + SNFI_MAC_CTL, reg,
> +					!(reg & MAC_WIP), 10,
> +					MTK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(snfi->dev, "polling flash update timeout\n");
> +		return -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mtk_snfi_mac_disable(struct mtk_snfi *snfi)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MAC_CTL);
> +	reg &= ~(MAC_TRIG | MAC_EN);
> +	writel(reg, snfi->regs + SNFI_MAC_CTL);
> +}
> +
> +static int mtk_snfi_mac_op(struct mtk_snfi *snfi)
Nitpicking, I do not see any 'op' code here.
Not sure if function name is appropriate.
> +{
> +	int ret = 0;
> +
> +	mtk_snfi_mac_enable(snfi);
> +	ret = mtk_snfi_mac_trigger(snfi);
> +	mtk_snfi_mac_disable(snfi);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t mtk_snfi_irq(int irq, void *id)
> +{
> +	struct mtk_snfi *snfi = id;
> +	u16 sta, ien;
> +
> +	sta = readw_relaxed(snfi->regs + NFI_INTR_STA);
> +	ien = readw_relaxed(snfi->regs + NFI_INTR_EN);
> +
> +	if (!(sta & ien))
> +		return IRQ_NONE;
> +
> +	writew(~sta & ien, snfi->regs + NFI_INTR_EN);
> +	complete(&snfi->done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_snfi_enable_clk(struct device *dev, struct mtk_snfi *snfi)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(snfi->nfi_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable nfi clk\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(snfi->spi_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable spi clk\n");
> +		clk_disable_unprepare(snfi->nfi_clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_snfi_disable_clk(struct mtk_snfi *snfi)
> +{
> +	clk_disable_unprepare(snfi->nfi_clk);
> +	clk_disable_unprepare(snfi->spi_clk);
> +}
> +
> +static int mtk_snfi_reset(struct mtk_snfi *snfi)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL) | SW_RST;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	ret = readw_poll_timeout(snfi->regs + SNFI_STA_CTL1, reg,
> +				 !(reg & SPI_STATE), 50,
> +				 MTK_RESET_TIMEOUT);
> +	if (ret) {
> +		dev_warn(snfi->dev, "spi state active in reset [0x%x] = 0x%x\n",
> +			 SNFI_STA_CTL1, reg);
> +		return ret;
> +	}
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg &= ~SW_RST;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	writew(CON_FIFO_FLUSH | CON_NFI_RST, snfi->regs + NFI_CON);
> +	ret = readw_poll_timeout(snfi->regs + NFI_STA, reg,
> +				 !(reg & NFI_FSM_MASK), 50,
> +				 MTK_RESET_TIMEOUT);
> +	if (ret) {
> +		dev_warn(snfi->dev, "nfi active in reset [0x%x] = 0x%x\n",
> +			 NFI_STA, reg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_snfi_rx_dma(struct spi_mem *mem,
> +			   const struct spi_mem_op *op)
> +{
> +	struct mtk_snfi *snfi = spi_controller_get_devdata(mem->spi->master);
> +	dma_addr_t dma_addr;
> +	u32 reg;
> +	int ret;
> +
> +	dma_addr = dma_map_single(snfi->dev, op->data.buf.in,
> +				  op->data.nbytes, DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(snfi->dev, dma_addr);
> +	if (ret) {
> +		dev_err(snfi->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = readl_relaxed(snfi->regs + NFI_SECCUS_SIZE);
> +	reg &= ~SECUS_SIZE_MASK;
> +	reg |= op->data.nbytes;
> +	writel(reg, snfi->regs + NFI_SECCUS_SIZE);
> +
> +	reg |= ((op->cmd.opcode & RD_CMD_MASK) |
> +	       (op->dummy.nbytes << 3 << RD_DUMMY_SHIFT));
> +	writel(reg, snfi->regs + SNFI_RD_CTL2);
> +	writel((op->addr.val & RD_ADDR_MASK), snfi->regs + SNFI_RD_CTL3);
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg |= RD_CUSTOM_EN;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	writel(op->data.nbytes, snfi->regs + SNFI_MISC_CTL2);
> +	writew(1 << CON_SEC_SHIFT, snfi->regs + NFI_CON);
> +
> +	reg = CNFG_READ_EN | CNFG_DMA_BURST_EN | CNFG_DMA | CNFG_OP_CUST;
> +	writew(reg, snfi->regs + NFI_CNFG);
> +
> +	writel(lower_32_bits(dma_addr), snfi->regs + NFI_STRADDR);
> +	readw_relaxed(snfi->regs + NFI_INTR_STA);
> +	writew(INTR_AHB_DONE_EN, snfi->regs + NFI_INTR_EN);
> +
> +	init_completion(&snfi->done);
> +
> +	/* Set dummy command to trigger NFI enter SPI mode */
> +	writew(NAND_CMD_DUMMYREAD, snfi->regs + NFI_CMD);
> +	reg = readl_relaxed(snfi->regs + NFI_CON) | CON_BRD;
> +	writew(reg, snfi->regs + NFI_CON);
> +
> +	ret = wait_for_completion_timeout(&snfi->done, msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(snfi->dev, "read ahb done timeout\n");
> +		writew(0, snfi->regs + NFI_INTR_EN);
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	ret = readl_poll_timeout_atomic(snfi->regs + NFI_BYTELEN, reg,
> +					ADDRCNTR_SEC(reg) >= 1, 10,
> +					MTK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(snfi->dev, "polling read byte len timeout\n");
> +		ret = -EIO;
> +	}
> +
> +out:
> +	dma_unmap_single(snfi->dev, dma_addr, op->data.nbytes, DMA_FROM_DEVICE);
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg &= ~RD_CUSTOM_EN;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	return ret;
> +}
> +
> +static int mtk_snfi_tx_dma(struct spi_mem *mem,
> +			   const struct spi_mem_op *op)
> +{
> +	struct mtk_snfi *snfi = spi_controller_get_devdata(mem->spi->master);
> +	dma_addr_t dma_addr;
> +	u32 reg;
> +	int ret;
> +
> +	dma_addr = dma_map_single(snfi->dev, op->data.buf.in, op->data.nbytes,
> +				  DMA_TO_DEVICE);
> +	ret = dma_mapping_error(snfi->dev, dma_addr);
> +	if (ret) {
> +		dev_err(snfi->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = readl_relaxed(snfi->regs + NFI_SECCUS_SIZE);
> +	reg &= ~SECUS_SIZE_MASK;
> +	reg |= op->data.nbytes;
> +	writel(reg, snfi->regs + NFI_SECCUS_SIZE);
> +
> +	reg = (op->cmd.opcode << WR_LOAD_CMD_SHIFT);
> +	writel(reg, snfi->regs + SNFI_PG_CTL1);
> +	writel(op->addr.val & WR_LOAD_ADDR_MASK, snfi->regs + SNFI_PG_CTL2);
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg |= WR_CUSTOM_EN;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	writel(op->data.nbytes << WR_LEN_SHIFT, snfi->regs + SNFI_MISC_CTL2);
> +	writew(1 << CON_SEC_SHIFT, snfi->regs + NFI_CON);
> +
> +	reg = CNFG_DMA | CNFG_DMA_BURST_EN | CNFG_OP_PROGRAM;
> +	writew(reg, snfi->regs + NFI_CNFG);
> +
> +	writel(lower_32_bits(dma_addr), snfi->regs + NFI_STRADDR);
> +	readw_relaxed(snfi->regs + NFI_INTR_STA);
> +	writew(INTR_AHB_DONE_EN, snfi->regs + NFI_INTR_EN);
> +
> +	init_completion(&snfi->done);
> +
> +	/* Set dummy command to trigger NFI enter SPI mode */
> +	writew(NAND_CMD_DUMMYPROG, snfi->regs + NFI_CMD);
> +	reg = readl_relaxed(snfi->regs + NFI_CON) | CON_BWR;
> +	writew(reg, snfi->regs + NFI_CON);
> +
> +	ret = wait_for_completion_timeout(&snfi->done, msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(snfi->dev, "read ahb done timeout\n");
> +		writew(0, snfi->regs + NFI_INTR_EN);
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	ret = readl_poll_timeout_atomic(snfi->regs + NFI_ADDRCNTR, reg,
> +					ADDRCNTR_SEC(reg) >= 1,
> +					10, MTK_TIMEOUT);
> +	if (ret) {
> +		dev_err(snfi->dev, "polling write sector count timeout\n");
> +		ret = -EIO;
> +	}
> +
> +out:
> +	dma_unmap_single(snfi->dev, dma_addr, op->data.nbytes, DMA_TO_DEVICE);
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg &= ~WR_CUSTOM_EN;
> +	writel(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	return ret;
> +}
> +
> +static int mtk_snfi_trx_mac(struct mtk_snfi *snfi,
> +			    const u8 *txbuf, u8 *rxbuf,
> +			    const u32 txlen, const u32 rxlen)
> +{
> +	u32 i, j, reg, tmp;
> +	u8 *p_tmp = (u8 *)(&tmp);
> +	u32 addr_offset = 0;
> +	int ret = 0;
> +
> +	/* Move tx data to SPI_GPRAM */
> +	for (i = 0; i < txlen; ) {
> +		for (j = 0, tmp = 0; i < txlen && j < 4; i++, j++)
> +			p_tmp[j] = txbuf[i];
> +
> +		writel(tmp, snfi->regs + SNFI_GPRAM_DATA + addr_offset);
> +		addr_offset += 4;
> +	}
> +
> +	writel(txlen, snfi->regs + SNFI_MAC_OUTL);
> +	writel(rxlen, snfi->regs + SNFI_MAC_INL);
> +	ret = mtk_snfi_mac_op(snfi);
> +	if (ret)
> +		return ret;
> +
> +	/* Get tx data from SPI_GPRAM */
Get tx data? Seems to get rx data here.
> +	if (rxlen)
The same with tx flow above, rxlen valid check here should be useless,
because you check it using for case below.
> +		for (i = 0, addr_offset = rounddown(txlen, 4); i < rxlen; ) {
Also, why use txlen in rx flow? Maybe we need a description here.
> +			reg = readl_relaxed(snfi->regs +
> +					    SNFI_GPRAM_DATA + addr_offset);
> +			for (j = 0; i < rxlen && j < 4; i++, j++, rxbuf++) {
> +				if (i == 0)
> +					j = txlen % 4;
> +				*rxbuf = (reg >> (j * 8)) & 0xff;
> +			}
> +			addr_offset += 4;
> +		}
> +
> +	return ret;
> +}
> +
> +static int mtk_snfi_exec_op(struct spi_mem *mem,
> +			    const struct spi_mem_op *op)
> +
> +{
> +	struct mtk_snfi *snfi = spi_controller_get_devdata(mem->spi->master);
> +	u32 trx_size, txlen = 0, rxlen = 0;
> +	u8 *txbuf, *rxbuf, *buf;
> +	int i, ret = 0;
> +
> +	ret = mtk_snfi_reset(snfi);
> +	if (ret) {
> +		dev_warn(snfi->dev, "reset snfi fail\n");
> +		return ret;
> +	}
> +
> +	trx_size = sizeof(op->cmd.opcode) + op->addr.nbytes +
> +		     op->dummy.nbytes + op->data.nbytes;
> +
> +	/*
> +	 * If trx data is larger than SNFI_GPRAM_MAX_LEN,
> +	 * use SNFI custom DMA mode.
> +	 */
> +	if (trx_size > SNFI_GPRAM_MAX_LEN) {
I saw you can configure any data length using register NFI_SECCUS_SIZE.
So why differentiate size smaller than SNFI_GPRAM_MAX_LEN ?
>From my point, they are the same.
> +		if (op->data.dir == SPI_MEM_DATA_IN)
> +			ret = mtk_snfi_rx_dma(mem, op);
> +		else
> +			ret = mtk_snfi_tx_dma(mem, op);
> +
> +		if (ret)
> +			dev_warn(snfi->dev, "snfi trx data fail\n");
> +
> +		return ret;
> +	}
> +
> +	txbuf = kzalloc(trx_size, GFP_KERNEL);
> +	if (!txbuf)
> +		return -ENOMEM;
> +
> +	txbuf[txlen++] = op->cmd.opcode;
Could you take a comment here to describe the data layout in mac mode?
> +
> +	if (op->addr.nbytes)
> +		for (i = 0; i < op->addr.nbytes; i++)
> +			txbuf[txlen++] = op->addr.val >>
> +					(8 * (op->addr.nbytes - i - 1));
> +
> +	txlen += op->dummy.nbytes;
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT) {
> +		buf = (u8 *)op->data.buf.out;
> +		for (i = 0; i < op->data.nbytes; i++)
> +			txbuf[txlen++] = buf[i];
> +	}
> +
> +	if (op->data.dir == SPI_MEM_DATA_IN) {
> +		rxbuf = (u8 *)op->data.buf.in;
> +		rxlen = op->data.nbytes;
> +	}
> +
> +	ret = mtk_snfi_trx_mac(snfi, txbuf, rxbuf, txlen, rxlen);
> +	kfree(txbuf);
> +
> +	return ret;
> +}
> +
> +static int mtk_snfi_init(struct mtk_snfi *snfi)
> +{
> +	int ret;
> +	u32 reg;
> +
> +	/* Reset the state machine and data FIFO */
> +	ret = mtk_snfi_reset(snfi);
> +	if (ret)
> +		return ret;
> +
> +	readw_relaxed(snfi->regs + NFI_INTR_STA);
> +	writew(0, snfi->regs + NFI_INTR_EN);
> +
> +	reg = readl_relaxed(snfi->regs + SNFI_MISC_CTL);
> +	reg &= ~(RD_MODE_MASK | WR_X4_EN);
> +	writew(reg, snfi->regs + SNFI_MISC_CTL);
> +
> +	writel(SECUS_SIZE_EN, snfi->regs + NFI_SECCUS_SIZE);
> +	writel(SNFI_MODE_EN, snfi->regs + SNFI_CNFG);
> +
> +	return 0;
> +}
> +
> +static bool mtk_snfi_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	int ret = 0;
> +
> +	if (op->cmd.buswidth != 1)
> +		ret |= -ENOTSUPP;
> +
> +	if (op->addr.buswidth && op->addr.buswidth != 1)
> +		ret |= -ENOTSUPP;
> +
> +	if (op->dummy.buswidth && op->dummy.buswidth != 1)
> +		ret |= -ENOTSUPP;
> +
> +	if (op->data.buswidth && op->data.buswidth != 1)
> +		ret |= -ENOTSUPP;
Does the controller really only support 1x mode ?
Should we confirm it?
> +
> +	if (ret)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int mtk_snfi_adjust_op_size(struct spi_mem *mem,
> +				   struct spi_mem_op *op)
> +{
> +	if (op->data.nbytes > SECUS_MAX_SIZE)
> +		op->data.nbytes = SECUS_MAX_SIZE;
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops mtk_snfi_ops = {
> +	.adjust_op_size = mtk_snfi_adjust_op_size,
> +	.supports_op = mtk_snfi_supports_op,
> +	.exec_op = mtk_snfi_exec_op,
> +};
> +
> +static const struct of_device_id mtk_snfi_id_table[] = {
> +	{ .compatible = "mediatek,mt7622-snfi", },
> +	{  /* sentinel */ }
> +};
> +
> +static int mtk_snfi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct spi_controller *ctlr;
> +	struct mtk_snfi *snfi;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*snfi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	snfi = spi_controller_get_devdata(ctlr);
> +	snfi->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	snfi->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(snfi->regs)) {
> +		ret = PTR_ERR(snfi->regs);
> +		goto err_put_master;
> +	}
> +
> +	snfi->nfi_clk = devm_clk_get(dev, "nfi_clk");
> +	if (IS_ERR(snfi->nfi_clk)) {
> +		dev_err(dev, "no nfi clk\n");
> +		ret = PTR_ERR(snfi->nfi_clk);
> +		goto err_put_master;
> +	}
> +
> +	snfi->spi_clk = devm_clk_get(dev, "spi_clk");
> +	if (IS_ERR(snfi->spi_clk)) {
> +		dev_err(dev, "no spi clk\n");
> +		ret = PTR_ERR(snfi->spi_clk);
> +		goto err_put_master;
> +	}
> +
> +	ret = mtk_snfi_enable_clk(dev, snfi);
> +	if (ret)
> +		goto err_put_master;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no snfi irq resource\n");
> +		ret = -EINVAL;
> +		goto clk_disable;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, mtk_snfi_irq, 0, "mtk-snfi", snfi);
> +	if (ret) {
> +		dev_err(dev, "failed to request snfi irq\n");
> +		goto clk_disable;
> +	}
> +
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(dev, "failed to set dma mask\n");
> +		goto clk_disable;
> +	}
> +
> +	ctlr->dev.of_node = np;
> +	ctlr->mem_ops = &mtk_snfi_ops;
> +
> +	ret = mtk_snfi_init(snfi);
> +	if (ret) {
> +		dev_err(dev, "failed to init snfi\n");
> +		goto clk_disable;
> +	}
> +
> +	ret = devm_spi_register_master(dev, ctlr);
> +	if (ret)
> +		goto clk_disable;
> +
> +	return 0;
> +
> +clk_disable:
> +	mtk_snfi_disable_clk(snfi);
> +
> +err_put_master:
> +	spi_master_put(ctlr);
> +
> +	return ret;
> +}
> +
> +static int mtk_snfi_remove(struct platform_device *pdev)
> +{
> +	struct mtk_snfi *snfi = platform_get_drvdata(pdev);
> +
> +	mtk_snfi_disable_clk(snfi);
> +
> +	return 0;
> +}
> +
> +static int mtk_snfi_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct mtk_snfi *snfi = platform_get_drvdata(pdev);
> +
> +	mtk_snfi_disable_clk(snfi);
> +
> +	return 0;
> +}
> +
> +static int mtk_snfi_resume(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_snfi *snfi = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = mtk_snfi_enable_clk(dev, snfi);
> +	if (ret)
> +		return ret;
> +
> +	ret = mtk_snfi_init(snfi);
> +	if (ret)
> +		dev_err(dev, "failed to init snfi\n");
> +
> +	return ret;
> +}
> +
> +static struct platform_driver mtk_snfi_driver = {
> +	.driver = {
> +		.name	= "mtk-snfi",
> +		.of_match_table = mtk_snfi_id_table,
> +	},
> +	.probe		= mtk_snfi_probe,
> +	.remove		= mtk_snfi_remove,
> +	.suspend	= mtk_snfi_suspend,
> +	.resume		= mtk_snfi_resume,
> +};
> +
> +module_platform_driver(mtk_snfi_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Xiangsheng Hou <xiangsheng.hou@mediatek.com>");
> +MODULE_DESCRIPTION("Mediatek SPI Nand Interface Driver");

Thanks,
Xiaolei


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
