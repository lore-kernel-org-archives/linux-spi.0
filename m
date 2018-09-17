From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] spi: Add MXIC controller driver
Date: Mon, 17 Sep 2018 14:09:22 +0200
Message-ID: <20180917140922.3132ab99@bbrezillon>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
        <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, 17 Sep 2018 15:16:18 +0800
masonccyang@mxic.com.tw wrote:

> +
> +static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> +				const struct spi_mem_op *op)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
> +	int nio = 1, i, ret;
> +	u32 ss_ctrl;
> +	u8 addr[8];
> +
> +	ret = mxic_spi_clk_setup(mem->spi);
> +	if (ret)
> +		return ret;

Hm, can we change the rate when the clk/PLL is enabled? If not then
you'll have to first call pm_runtime_get_sync() to start from a know
state, then inside mxic_spi_clk_setup(), call mxic_spi_clk_disable(),
change the rate and call mxic_spi_clk_enable().

> +
> +	ret = mxic_spi_clk_enable(mxic);
> +	if (ret)
> +		return ret;

Hm, why do you need that one? Isn't it already taken care of by the
core when it calls pm_runtime_get_sync() here [1]?

> +
> +	if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
> +		nio = 4;
> +	else if (mem->spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
> +		nio = 2;
> +
> +	writel(HC_CFG_NIO(nio) |
> +	       HC_CFG_TYPE(mem->spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
> +	       HC_CFG_SLV_ACT(mem->spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1) |
> +	       HC_CFG_MAN_CS_EN,
> +	       mxic->regs + HC_CFG);
> +	writel(HC_EN_BIT, mxic->regs + HC_EN);
> +
> +	ss_ctrl = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
> +
> +	if (op->addr.nbytes)
> +		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
> +			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
> +
> +	if (op->dummy.nbytes)
> +		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
> +
> +	if (op->data.nbytes) {
> +		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
> +		if (op->data.dir == SPI_MEM_DATA_IN)
> +			ss_ctrl |= OP_READ;
> +	}
> +
> +	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
> +
> +	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> +	       mxic->regs + HC_CFG);
> +
> +	ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < op->addr.nbytes; i++)
> +		addr[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
> +	ret = mxic_spi_data_xfer(mxic, addr, NULL, op->addr.nbytes);
> +	if (ret)
> +		goto out;
> +
> +	ret = mxic_spi_data_xfer(mxic, NULL, NULL, op->dummy.nbytes);
> +	if (ret)
> +		goto out;
> +
> +	ret = mxic_spi_data_xfer(mxic,
> +				 op->data.dir == SPI_MEM_DATA_OUT ?
> +				 op->data.buf.out : NULL,
> +				 op->data.dir == SPI_MEM_DATA_IN ?
> +				 op->data.buf.in : NULL,
> +				 op->data.nbytes);
> +
> +out:
> +	writel(readl(mxic->regs + HC_CFG) & ~HC_CFG_MAN_CS_ASSERT,
> +	       mxic->regs + HC_CFG);
> +	writel(0, mxic->regs + HC_EN);
> +
> +	mxic_spi_clk_disable(mxic);
> +
> +	return ret;
> +}
> +
> +static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
> +	.supports_op = mxic_spi_mem_supports_op,
> +	.exec_op = mxic_spi_mem_exec_op,
> +};
> +
> +static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +
> +	if (!lvl) {
> +		if (mxic_spi_clk_setup(spi))
> +			return;
> +		if (mxic_spi_clk_enable(mxic))
> +			return;

Same here. I'd expect the clks to be enabled by the core [2].

> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> +		       mxic->regs + HC_CFG);
> +		writel(HC_EN_BIT, mxic->regs + HC_EN);
> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> +		       mxic->regs + HC_CFG);
> +	} else {
> +		writel(readl(mxic->regs + HC_CFG) & ~HC_CFG_MAN_CS_ASSERT,
> +		       mxic->regs + HC_CFG);
> +		writel(0, mxic->regs + HC_EN);
> +		mxic_spi_clk_disable(mxic);
> +	}
> +}
> +

[...]

> +
> +static int __maybe_unused mxic_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct mxic_spi *mxic = spi_master_get_devdata(master);
> +
> +	clk_disable_unprepare(mxic->ps_clk);

Hm, why not putting the ->ps_clk enabling bits in the runtime PM hooks? 

> +
> +	spi_master_suspend(master);
> +
> +	return 0;
> +}
> +

[...]

> +
> +static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct mxic_spi *mxic = spi_master_get_devdata(master);
> +
> +	dev_dbg(dev, "dis-able ps_clock.\n");

		      ^ disable

And I'm not even sure we need this trace here. Looks like some
leftovers from your debugging.

> +	clk_disable_unprepare(mxic->ps_clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct mxic_spi *mxic = spi_master_get_devdata(master);
> +	int ret;
> +
> +	dev_dbg(dev, "en-able ps_clock.\n");

		      ^enable

> +	ret = clk_prepare_enable(mxic->ps_clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable ps_clock.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mxic_spi_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mxic_spi_runtime_suspend,
> +			   mxic_spi_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(mxic_spi_suspend, mxic_spi_resume)
> +};
> +
> +static int mxic_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_master *master;
> +	struct resource *res;
> +	struct mxic_spi *mxic;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct mxic_spi));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	mxic = spi_master_get_devdata(master);
> +
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	mxic->ps_clk = devm_clk_get(&pdev->dev, "ps_clk");
> +	if (IS_ERR(mxic->ps_clk))
> +		return PTR_ERR(mxic->ps_clk);
> +
> +	mxic->send_clk = devm_clk_get(&pdev->dev, "send_clk");
> +	if (IS_ERR(mxic->send_clk))
> +		return PTR_ERR(mxic->send_clk);
> +
> +	mxic->send_dly_clk = devm_clk_get(&pdev->dev, "send_dly_clk");
> +	if (IS_ERR(mxic->send_dly_clk))
> +		return PTR_ERR(mxic->send_dly_clk);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	mxic->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mxic->regs))
> +		return PTR_ERR(mxic->regs);
> +
> +	ret = clk_prepare_enable(mxic->ps_clk);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	master->auto_runtime_pm = true;
> +
> +	master->num_chipselect = 1;
> +	master->setup = mxic_spi_setup;
> +	master->mem_ops = &mxic_spi_mem_ops;
> +
> +	master->set_cs = mxic_spi_set_cs;
> +	master->transfer_one = mxic_spi_transfer_one;
> +	master->bits_per_word_mask = SPI_BPW_MASK(8);
> +	master->mode_bits = SPI_CPOL | SPI_CPHA |
> +			SPI_RX_DUAL | SPI_TX_DUAL |
> +			SPI_RX_QUAD | SPI_TX_QUAD;
> +
> +	mxic_spi_hw_init(mxic);
> +
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);

Okay, I'll let others review the runtime PM init/cleanup bits, because
I'm not an expert, but I don't remember seeing this
pm_runtime_set_active()+pm_runtime_mark_last_busy()+pm_runtime_put_autosuspend()
dance in the drivers I worked on. Most probably because they were not
using autosuspend.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/spi-mem.c#L210
[2]https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/spi.c#L1214
