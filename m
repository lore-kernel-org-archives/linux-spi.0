From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Date: Tue, 05 Feb 2013 14:21:28 +0000
Message-ID: <20130205142128.2E28D3E1265@localhost>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 27 Jan 2013 14:35:04 +0800, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> Use GFP_DMA in order to ensure that the memory we allocate for transfers
> in spi_write_then_read() can be DMAed. On most platforms this will have
> no effect.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 19ee901..14d0fba 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1656,7 +1656,8 @@ int spi_write_then_read(struct spi_device *spi,
>  	 * using the pre-allocated buffer or the transfer is too large.
>  	 */
>  	if ((n_tx + n_rx) > SPI_BUFSIZ || !mutex_trylock(&lock)) {
> -		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx), GFP_KERNEL);
> +		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx),
> +				    GFP_KERNEL | GFP_DMA);
>  		if (!local_buf)
>  			return -ENOMEM;
>  	} else {
> -- 
> 1.7.10.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
