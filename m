From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2] spi: tegra: add spi driver for SLINK controller
Date: Mon, 29 Oct 2012 13:14:45 -0600
Message-ID: <508ED5A5.3000703@wwwdotorg.org>
References: <1351531104-1604-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351531104-1604-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 10/29/2012 11:18 AM, Laxman Dewangan wrote:
> Tegra20/Tegra30 supports the spi interface through its SLINK
> controller. Add spi driver for SLINK controller.

> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig

> +config SPI_TEGRA20_SLINK
> +	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
> +	depends on ARCH_TEGRA && TEGRA20_APB_DMA

I think it depends on DMAENGINE, not the specific driver now, doesn't it?

> +static unsigned tegra_slink_fill_tx_fifo_from_client_txbuf(
> +	struct tegra_slink_data *tspi, struct spi_transfer *t)

> +	if (tspi->is_packed) {
> +		fifo_words_left = tx_empty_count * tspi->words_per_32bit;
> +		written_words = min(fifo_words_left, tspi->curr_dma_words);
> +		nbytes = written_words * tspi->bytes_per_word;
> +		max_n_32bit = DIV_ROUND_UP(nbytes, 4);
> +		for (count = 0; count < max_n_32bit; count++) {
> +			x = 0;
> +			for (i = 0; (i < 4) && nbytes; i++, nbytes--)
> +				x |= (*tx_buf++) << (i*8);
> +			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
> +		}
> +	} else {
> +		max_n_32bit = min(tspi->curr_dma_words,  tx_empty_count);
> +		written_words = max_n_32bit;
> +		nbytes = written_words * tspi->bytes_per_word;
> +		for (count = 0; count < max_n_32bit; count++) {
> +			x = 0;
> +			for (i = 0; nbytes && (i < tspi->bytes_per_word);
> +							i++, nbytes--)
> +				x |= ((*tx_buf++) << i*8);
> +			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
> +		}
> +	}

The if and the else there are basically identical now. Can't the else
branch simply be replaced by the if branch? At most I think the
difference comes down to max_n_32bit v.s. fifo_words_left calculations
being slight different; everything else is the same.

I suppose this isn't a big deal though; we could clean it up later if
necessary.

> +static int tegra_slink_start_cpu_based_transfer(
> +		struct tegra_slink_data *tspi, struct spi_transfer *t)

> +	tspi->is_curr_dma_xfer = false;
> +	if (tspi->is_packed) {
> +		val |= SLINK_PACKED;
> +		tegra_slink_writel(tspi, val, SLINK_DMA_CTL);
> +		udelay(1);
> +		wmb();

Why the udelay() and wmb()?

> +static int tegra_slink_runtime_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
> +
> +	tegra_slink_clk_unprepare(tspi);
> +	return 0;
> +}
> +
> +static int tegra_slink_runtime_resume(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
> +
> +	return tegra_slink_clk_prepare(tspi);
> +}

Why not move the body of tegra_slink_clk_{un,prepare} inside those
functions, since they're only called from those functions?

> +MODULE_ALIAS("platform:tegra_slink-slink");

I think that's a typo.
