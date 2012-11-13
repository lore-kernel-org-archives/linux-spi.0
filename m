From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for sflash controller
Date: Tue, 13 Nov 2012 10:25:45 -0700
Message-ID: <50A28299.6080809@wwwdotorg.org>
References: <1352782854-25351-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1352782854-25351-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/12/2012 10:00 PM, Laxman Dewangan wrote:
> Nvidia's Tegra20 have the SPI (SFLASH) controller to
> interface with spi flash device which is used for system
> boot. Add the spi driver for this controller.

> diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c

> +static void tegra_sflash_clear_status(struct tegra_sflash_data *tsd)
> +{
> +	unsigned long val;
> +	unsigned long val_write = 0;
> +
> +	val = tegra_sflash_readl(tsd, SPI_STATUS);

Why the read of the unused value. Is this to flush earlier bus
transactions, or just left over? If for bus flushing, a comment would be
useful.

> +	/* Write 1 to clear status register */
> +	val_write = SPI_RDY | SPI_FIFO_ERROR;
> +	tegra_sflash_writel(tsd, val_write, SPI_STATUS);
> +}

> +static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
> +{
> +	struct spi_transfer *t = tsd->curr_xfer;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tsd->lock, flags);
> +	if (tsd->tx_status ||  tsd->rx_status ||

Nit: double-space after first || above.

> +static struct tegra_spi_platform_data *tegra_sflash_parse_dt(
> +		struct platform_device *pdev)

> +	prop = of_get_property(np, "spi-max-frequency", NULL);
> +	if (prop)
> +		pdata->spi_max_frequency = be32_to_cpup(prop);

Perhaps use of_property_read_u32()?

> +static int __devinit tegra_sflash_probe(struct platform_device *pdev)

> +	tsd->clk = devm_clk_get(&pdev->dev, "spi");
> +	if (IS_ERR(tsd->clk)) {
> +		dev_err(&pdev->dev, "can not get clock\n");
> +		ret = PTR_ERR(tsd->clk);
> +		goto exit_free_irq;
> +	}
> +
> +
> +	tsd->spi_max_frequency = pdata->spi_max_frequency;

Nit: Double blank-line there.

> +static int tegra_sflash_resume(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime failed, e = %d\n", ret);
> +		return ret;
> +	}
> +	tegra_sflash_writel(tsd, tsd->command_reg, SPI_COMMAND);
> +	pm_runtime_put(dev);

Can we avoid this whole function simply by programming SPI_COMMAND at
the start of each transaction? That seems simpler. I assume that
shouldn't e.g. leave any chip-selects in some bad state, or at least if
it does, that shouldn't be a problem, because before the driver probes()
at kernel boot, SPI_COMMAND won't have been programmed either.

Aside from that,

Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks.

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
