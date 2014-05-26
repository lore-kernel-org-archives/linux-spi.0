From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] spi: rspi: Round up division to avoid slave overclocking
Date: Mon, 26 May 2014 10:41:41 +0900
Message-ID: <20140526014140.GH31096@verge.net.au>
References: <1400782055-19609-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400782055-19609-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 22, 2014 at 08:07:35PM +0200, Geert Uytterhoeven wrote:
> The calculation of the bit rate divider used a standard C division, which
> rounds down the quotient. This may lead to a higher bitrate than requested.
> Round up to avoid this.
> 
> E.g. on Koelsch, the SPI flash (configured for 30 MHz) was driven at 48.75
> MHz. After this patch it's driven at a safe 24.375 MHz.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Simon: I think you want this in renesas-backports.

Thanks, I'll backport it once its been accepted by Mark.

>  drivers/spi/spi-rspi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 1fb0ad213324..5639f9529e0b 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -266,7 +266,8 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
>  	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
>  
>  	/* Sets transfer bit rate */
> -	spbr = clk_get_rate(rspi->clk) / (2 * rspi->max_speed_hz) - 1;
> +	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk),
> +			    2 * rspi->max_speed_hz) - 1;
>  	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
>  
>  	/* Disable dummy transmission, set 16-bit word access, 1 frame */
> @@ -302,7 +303,8 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
>  	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
>  
>  	/* Sets transfer bit rate */
> -	spbr = clk_get_rate(rspi->clk) / (2 * rspi->max_speed_hz) - 1;
> +	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk),
> +			    2 * rspi->max_speed_hz) - 1;
>  	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
>  
>  	/* Disable dummy transmission, set byte access */
> @@ -335,7 +337,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
>  	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
>  
>  	/* Sets transfer bit rate */
> -	spbr = clk_get_rate(rspi->clk) / (2 * rspi->max_speed_hz);
> +	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->max_speed_hz);
>  	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
>  
>  	/* Disable dummy transmission, set byte access */
> -- 
> 1.9.1
> 
