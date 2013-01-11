From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 01/10] spi: tegra: Do not use clock name to get clock
Date: Fri, 11 Jan 2013 13:58:28 -0700
Message-ID: <50F07CF4.2090502@wwwdotorg.org>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/11/2013 01:01 AM, Prashant Gaikwad wrote:
> Since Tegra spi devices do not have multiple clocks, no need to use
> clock name to get the clock.

Cc'ing in the SPI maintainers as an FYI and for Acks; this patch needs
to go through the Tegra tree due to dependencies.

> Signed-off-by: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This series depends on v4 of Tegra's ccf-rework patch series.
> Tested on Ventana (Tegra20) and Cardhu (Tegra30).
> Rebased on Tegra's for-3.9/soc and for-3.9/cleanup.
> 
> Changes from V1:
> - Fixed clock lookup for SPI and nvec drivers.
> - Add clock information for nvec in device tree.
> ---
>  drivers/spi/spi-tegra20-sflash.c |    2 +-
>  drivers/spi/spi-tegra20-slink.c  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
> index 02feaa5..e5dce91 100644
> --- a/drivers/spi/spi-tegra20-sflash.c
> +++ b/drivers/spi/spi-tegra20-sflash.c
> @@ -525,7 +525,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
>  		goto exit_free_master;
>  	}
>  
> -	tsd->clk = devm_clk_get(&pdev->dev, "spi");
> +	tsd->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(tsd->clk)) {
>  		dev_err(&pdev->dev, "can not get clock\n");
>  		ret = PTR_ERR(tsd->clk);
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index fa208a5..e255e7a 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1191,7 +1191,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
>  		goto exit_free_master;
>  	}
>  
> -	tspi->clk = devm_clk_get(&pdev->dev, "slink");
> +	tspi->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(tspi->clk)) {
>  		dev_err(&pdev->dev, "can not get clock\n");
>  		ret = PTR_ERR(tspi->clk);
> 
