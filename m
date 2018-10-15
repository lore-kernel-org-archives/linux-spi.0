From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 1/2] spi: Add MXIC controller driver
Date: Mon, 15 Oct 2018 10:54:35 +0200
Message-ID: <20181015105435.6c869a56@bbrezillon>
References: <1539591976-30430-1-git-send-email-masonccyang@mxic.com.tw>
        <1539591976-30430-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539591976-30430-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, 15 Oct 2018 16:26:15 +0800
masonccyang@mxic.com.tw wrote:


> +
> +static int mxic_spi_setup(struct spi_device *spi)
> +{
> +	return 0;
> +}

Drop this empty function and leave ->setup to NULL.

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

Don't you need at least the ps_clk to be enabled to write to the MXIC
regs? Also, what happens when the ps_clk is disabled? Is reg content
preserved? If not, then you should probably move the mxic_spi_hw_init()
in the mxic_spi_runtime_resume() function so that you always start from
a known state.

> +
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");
> +		goto err_put_master;
> +	}
> +
> +	return 0;
> +
> +err_put_master:
> +	spi_master_put(master);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int mxic_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_master(master);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mxic_spi_of_ids[] = {
> +	{ .compatible = "mxicy,mx25f0a-spi", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxic_spi_of_ids);
> +
> +static struct platform_driver mxic_spi_driver = {
> +	.probe = mxic_spi_probe,
> +	.remove = mxic_spi_remove,
> +	.driver = {
> +		.name = "mxic-spi",
> +		.of_match_table = mxic_spi_of_ids,
> +		.pm = &mxic_spi_dev_pm_ops,
> +	},
> +};
> +module_platform_driver(mxic_spi_driver);
> +
> +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
> +MODULE_DESCRIPTION("MX25F0A SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> +

Drop this blank line.

Regards,

Boris
