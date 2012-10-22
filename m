From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for SLINK controller
Date: Mon, 22 Oct 2012 13:28:26 +0100
Message-ID: <20121022122825.GD4477@opensource.wolfsonmicro.com>
References: <1350557233-31234-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350557233-31234-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2012 at 04:17:13PM +0530, Laxman Dewangan wrote:

> +		udelay(1);
> +		wmb();
> +	}
> +	tspi->dma_control_reg = val;
> +	val |= SLINK_DMA_EN;
> +	tegra_slink_writel(tspi, val, SLINK_DMA_CTL);
> +	return 0;
> +}
> +static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
> +			bool dma_to_memory)
> +{

Blank line between functions.

> +	tegra_slink_clk_disable(tspi);
> +	pm_runtime_put_sync(tspi->dev);
> +	return 0;

Throughout the code you're using pm_runtime_put_sync() - why does this
need to be _sync()?  Can't we just use a regular put()?  If we can't we
should document why.

> +static int tegra_slink_prepare_transfer(struct spi_master *master)
> +{
> +	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
> +
> +	pm_runtime_get_sync(tspi->dev);
> +	return 0;

Should really check the error code of the pm_runtime call here.

> +static struct tegra_spi_platform_data *tegra_slink_parese_dt(
> +		struct platform_device *pdev)
> +{

There doens't seem to be any binding documentation; binding
documentation is mandatory.

> +	prop = of_get_property(pdev->dev.of_node, "spi_max_frequency", NULL);
> +	if (prop)
> +		pdata->spi_max_frequency = be32_to_cpup(prop);
> +	else
> +		pdata->spi_max_frequency = 25000000; /* 25MHz */

Why is the default not being picked in the general non-OF case?

> +const struct tegra_slink_chip_data tegra30_spi_cdata = {
> +	.cs_hold_time = true,
> +};
> +
> +#ifdef CONFIG_OF
> +const struct tegra_slink_chip_data tegra20_spi_cdata = {
> +	.cs_hold_time = false,
> +};
> +
> +static struct of_device_id tegra_slink_of_match[] __devinitconst = {
> +	{ .compatible = "nvidia,tegra20-slink", .data = &tegra20_spi_cdata, },
> +	{ .compatible = "nvidia,tegra30-slink", .data = &tegra30_spi_cdata, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tegra_slink_of_match);
> +#endif

The ifdefs here look misplaced?

> +	spi_irq = platform_get_irq(pdev, 0);
> +	if (unlikely(spi_irq < 0)) {

Putting optimisation hints like unlikely() here is pointless.

> +	ret = devm_request_threaded_irq(&pdev->dev, tspi->irq,
> +			tegra_slink_isr, tegra_slink_isr_thread, IRQF_ONESHOT,
> +			dev_name(&pdev->dev), tspi);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
> +					tspi->irq);
> +		goto exit_free_master;
> +	}

Any use of devm_ IRQ functions is suspicous... why is this safe against
an interrupt firing after the SPI device has started to deallocate?

> +#ifdef CONFIG_PM_SLEEP
> +static int tegra_slink_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +
> +	spi_master_suspend(master);
> +	return 0;

Should use the return code of spi_master_suspend().

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhTvgAAoJELSic+t+oim9cn8P/0hs3pvN4lEMf3rBfn1ToOQz
T0cBXeR0YZgzfVio9JPZX0PqA/D52PLTB3ltasCAhaYJmK0HqwB56O4IUwqXkqsO
yztJSWHSjqfR+yvlquvtZpKqqFRq/Rc3yp56ZLI6H9UBVnJRTWk/DzkUQSuUUfd6
HLQn1TQtMnnvBnHVcRS6+NL+OqSHQGNi3TKIeDt+tt87KOPaReJScPhYoKyRbwav
m98NtCaWNbSpP2GEJ5uI4pNszmEFyhfFVdO2WBPxXvHGtS3rpYQdEf2k87kcZejD
4wAE3r2F6+DXvS8ROxfl0Afyzm+NBWuF1uM+h3SSprXLmzU/BFLvYvlHCsyYadme
d4np/SFbQBTU99FmkZsLTKfUgvxQEtYbDWFJuPD0fr/8qc9cbUfotRoAbzoyzJUj
laiJgXHQAcuD9Ps+va4t4D9cQDTEx7OB1oA3STbtcXI6iYpdXwhmlzPNFw1D6F4M
Ujhc8JOBsLpW1EJi/JQa5b3ufrUpHrUgMj6V3BNYzis+KzHwtVXSdqUhCESA3MuG
Egt6Ek9/Fq0HTveZPMvkEMjYuPhrxg3Ju8AHeiWLNc4CnX6blNbjJj5fBK8AoUlN
g3agSTPczeLINn/6dxXBmjAUZemwv1YAKWQ5wALy2PAk+H+7WB1V/0ha7NkGdtkO
SYYSk0b4gqwMa1wysByz
=vk8V
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
