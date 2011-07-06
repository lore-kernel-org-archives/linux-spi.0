From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/tegra: Use engineering names in DT compatible
 property
Date: Tue, 5 Jul 2011 23:38:59 -0600
Message-ID: <20110706053859.GD9978@ponder.secretlab.ca>
References: <1309897082-22695-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1309897082-22695-1-git-send-email-swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 05, 2011 at 02:18:02PM -0600, Stephen Warren wrote:
> Engineering names are more stable than marketing names. Hence, use them
> for Device Tree compatible properties instead.
> 
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Grant, this is against devicetree/arm, and also makes sense for
> devicetree/test.

Applied to spi/next, thanks.

g.

> 
>  .../devicetree/bindings/spi/spi_nvidia.txt         |    2 +-
>  drivers/spi/spi_tegra.c                            |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi_nvidia.txt b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
> index bde450b..6b9e518 100644
> --- a/Documentation/devicetree/bindings/spi/spi_nvidia.txt
> +++ b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
> @@ -1,5 +1,5 @@
>  NVIDIA Tegra 2 SPI device
>  
>  Required properties:
> -- compatible : should be "nvidia,tegra250-spi".
> +- compatible : should be "nvidia,tegra20-spi".
>  - gpios : should specify GPIOs used for chipselect.
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> index 1e7de98..b0e3586 100644
> --- a/drivers/spi/spi_tegra.c
> +++ b/drivers/spi/spi_tegra.c
> @@ -598,7 +598,7 @@ MODULE_ALIAS("platform:spi_tegra");
>  
>  #ifdef CONFIG_OF
>  static struct of_device_id spi_tegra_of_match_table[] __devinitdata = {
> -	{ .compatible = "nvidia,tegra250-spi", },
> +	{ .compatible = "nvidia,tegra20-spi", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, spi_tegra_of_match_table);
> -- 
> 1.7.0.4
> 
