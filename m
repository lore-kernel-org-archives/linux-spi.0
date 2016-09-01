From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] spi: sh-msiof: Use ARCH_SHMOBILE instead of SUPERH
Date: Thu, 1 Sep 2016 15:42:02 +0200
Message-ID: <20160901134159.GA14300@verge.net.au>
References: <1472636225-27091-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472636225-27091-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 31, 2016 at 11:37:05AM +0200, Geert Uytterhoeven wrote:
> "spi_sh_msiof" is used on sh7723 and sh7724 only. As all of the above
> select ARCH_SHMOBILE, restrict its driver dependencies from SUPERH to
> ARCH_SHMOBILE.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 5c8e51e96888cc53..96087e9fc998461c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -556,7 +556,7 @@ config SPI_SC18IS602
>  config SPI_SH_MSIOF
>  	tristate "SuperH MSIOF SPI controller"
>  	depends on HAVE_CLK && HAS_DMA
> -	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> +	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
>  	help
>  	  SPI driver for SuperH and SH Mobile MSIOF blocks.
>  
> -- 
> 1.9.1
> 
