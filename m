From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/tegra: depend instead of select TEGRA_SYSTEM_DMA
Date: Mon, 2 Jan 2012 02:01:47 -0700
Message-ID: <20120102090147.GN18381@ponder.secretlab.ca>
References: <1324598277-4751-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1324598277-4751-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 22, 2011 at 03:57:57PM -0800, Olof Johansson wrote:
> It's unlikely that anyone ever wants to turn off SYSTEM_DMA, but just in
> case, it makes more sense to have the driver depend on it than select it.
> 
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

Applied, thanks

g.

> ---
>  drivers/spi/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3d292be..326f77a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -332,8 +332,7 @@ config SPI_STMP3XXX
>  
>  config SPI_TEGRA
>  	tristate "Nvidia Tegra SPI controller"
> -	depends on ARCH_TEGRA
> -	select TEGRA_SYSTEM_DMA
> +	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
>  	help
>  	  SPI driver for NVidia Tegra SoCs
>  
> -- 
> 1.7.8.GIT
> 
