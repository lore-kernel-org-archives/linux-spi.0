From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: spi-mem: MediaTek: Add SPI NAND Flash
 interface driver for MediaTek MT7622
Date: Tue, 23 Oct 2018 07:52:47 +0200
Message-ID: <20181023075247.004982c9@bbrezillon>
References: <1536716612-24610-1-git-send-email-xiangsheng.hou@mediatek.com>
 <1536716612-24610-4-git-send-email-xiangsheng.hou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
 linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bayi.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, benliang.zhao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
 xiaolei.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
To: Xiangsheng Hou <xiangsheng.hou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1536716612-24610-4-git-send-email-xiangsheng.hou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

+Mark (the SPI maintainer, please remember to Cc him next time you
send a SPI related patch).

Hi Xiangsheng,

On Wed, 12 Sep 2018 09:43:32 +0800
Xiangsheng Hou <xiangsheng.hou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:

Please add a commit message here.

> Signed-off-by: Xiangsheng Hou <xiangsheng.hou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/spi/Kconfig        |   10 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-mtk-snfi.c |  918 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 929 insertions(+)
>  create mode 100644 drivers/spi/spi-mtk-snfi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 671d078..9f94921 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -389,6 +389,16 @@ config SPI_MT65XX
>  	  say Y or M here.If you are not sure, say N.
>  	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
>  
> +config SPI_MTK_SNFI
> +	tristate "MediaTek SPI NAND interface"
> +	select MTD_SPI_NAND
> +	help
> +	  This selects the MediaTek(R) SPI NAND FLASH interface (SNFI)
> +	  driver, which could be found on MT7622 Soc, say Y or M here.
> +	  If you are not sure, say N. This driver use SPI NAND FLASH
> +          on-die ECC.

Should be aligned on the previous line.

> +	  Note Parallel Nand and SPI NAND is alternative on MediaTek SoCs.

There's a fundamental issue with this driver: spi-mem was designed to be
memory agnostic, and you seem to have a SPI controller that supports
only SPI NANDs. Is that correct, or is it just that you developed the
driver with SPI NANDs in  mind?

> +
>  config SPI_NUC900
>  	tristate "Nuvoton NUC900 series SPI"
>  	depends on ARCH_W90X900

> +static int mtk_snfc_read(struct spi_mem *mem,
> +			 const struct spi_mem_op *op)
> +{
> +	struct mtk_snfc *snfc = spi_controller_get_devdata(mem->spi->master);
> +	struct spinand_device *spinand = spi_mem_get_drvdata(mem);

Just one example of things I don't want to see in spi-mem drivers.
Clearly you're breaking the layering we're trying to enforce:

		       MTD
		------------------
		spi-nor | spinand
		------------------
		     spi-mem
		------------------
		       spi

spi-mem should no know nothing about the memory it's manipulating, all
it should do is execute SPI memory operations.

Don't know what's possible to do with your controller, and maybe it's
not able to execute random SPI memory operations, but in this case we
should consider a different solution to support this driver.

Do you have a public datasheet I can look at?

Regards,

Boris

> +	struct mtd_info *mtd = spinand_to_mtd(spinand);
> +	u32 sectors = mtd->writesize / snfc->caps->nand_sec_size;
> +	u32 reg, len, col_addr = 0;
> +	dma_addr_t dma_addr;
> +	int dummy_cycle, ret;
> +
> +	len = sectors * (snfc->caps->nand_sec_size +
> +			  snfc->spare_per_sector);
> +	dma_addr = dma_map_single(snfc->dev, snfc->buffer,
> +				  len, DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(snfc->dev, dma_addr);
> +	if (ret) {
> +		dev_err(snfc->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +
> +	/* set Read cache command and dummy cycle */
> +	dummy_cycle = (op->dummy.nbytes << 3) >> (ffs(op->dummy.buswidth) - 1);
> +	reg |= ((op->cmd.opcode & RD_CMD_MASK) |
> +	       (dummy_cycle << RD_DUMMY_SHIFT));
> +	writel(reg, snfc->regs + SNFI_RD_CTL2);
> +
> +	writel((col_addr & RD_ADDR_MASK), snfc->regs + SNFI_RD_CTL3);
> +
> +	reg = readl_relaxed(snfc->regs + SNFI_MISC_CTL);
> +	reg |= RD_CUSTOM_EN;
> +	reg &= ~(RD_MODE_MASK | WR_X4_EN);
> +
> +	/* set data and addr buswidth */
> +	if (op->data.buswidth == 4)
> +		reg |= RD_MODE_X4;
> +	else if (op->data.buswidth == 2)
> +		reg |= RD_MODE_X2;
> +
> +	if (op->addr.buswidth == 4 || op->addr.buswidth == 2)
> +		reg |= RD_QDUAL_IO;
> +	writel(reg, snfc->regs + SNFI_MISC_CTL);
> +
> +	writel(len, snfc->regs + SNFI_MISC_CTL2);
> +	writew((sectors << CON_SEC_SHIFT), snfc->regs + NFI_CON);
> +
> +	reg = CNFG_READ_EN | CNFG_DMA_BURST_EN | CNFG_DMA | CNFG_OP_CUST;
> +	writew(reg, snfc->regs + NFI_CNFG);
> +
> +	writel(lower_32_bits(dma_addr), snfc->regs + NFI_STRADDR);
> +	readw_relaxed(snfc->regs + NFI_INTR_STA);
> +	writew(INTR_AHB_DONE_EN, snfc->regs + NFI_INTR_EN);
> +
> +	init_completion(&snfc->done);
> +
> +	/* set dummy command to trigger NFI enter custom mode */
> +	writew(NAND_CMD_DUMMYREAD, snfc->regs + NFI_CMD);
> +	reg = readl_relaxed(snfc->regs + NFI_CON) | CON_BRD;
> +	writew(reg, snfc->regs + NFI_CON);
> +
> +	ret = wait_for_completion_timeout(&snfc->done, msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(snfc->dev, "read ahb done timeout\n");
> +		writew(0, snfc->regs + NFI_INTR_EN);
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	ret = readl_poll_timeout_atomic(snfc->regs + NFI_BYTELEN, reg,
> +					ADDRCNTR_SEC(reg) >= sectors, 10,
> +					MTK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(snfc->dev, "polling read byte len timeout\n");
> +		ret = -EIO;
> +	}
> +
> +out:
> +	dma_unmap_single(snfc->dev, dma_addr, len, DMA_FROM_DEVICE);
> +	reg = readl_relaxed(snfc->regs + SNFI_MISC_CTL);
> +	reg &= ~RD_CUSTOM_EN;
> +	writel(reg, snfc->regs + SNFI_MISC_CTL);
> +
> +	return ret;
> +}
