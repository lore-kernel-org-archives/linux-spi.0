From: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 14:30:59 +0200
Message-ID: <20150724123059.GL1931@pengutronix.de>
References: <1437716236-12715-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
To: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437716236-12715-1-git-send-email-larper-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 24, 2015 at 07:37:16AM +0200, Lars Persson wrote:
> This reverts commit 232a5adc5199 ("spi: bitbang: only toggle
> bitchanges") because it breaks bitbanged SPI on our MIPS system. I
> found two problems with the patch:
> - oldbit must initially be computed from bit position 7, 15 or 31 of
>   word depending on the value of bits.
> - The optimization also does not eliminate consecutive ones because
>   the compare of 1<<31 and 1 will be false (a bool only takes values 0
>   or 1).
> 
> Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
> ---
>  drivers/spi/spi-bitbang-txrx.h | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
> index 06b34e5..c616e41 100644
> --- a/drivers/spi/spi-bitbang-txrx.h
> +++ b/drivers/spi/spi-bitbang-txrx.h
> @@ -49,17 +49,12 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  {
>  	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
>  
> -	bool oldbit = !(word & 1);
>  	/* clock starts at inactive polarity */
>  	for (word <<= (32 - bits); likely(bits); bits--) {
>  
>  		/* setup MSB (to slave) on trailing edge */
> -		if ((flags & SPI_MASTER_NO_TX) == 0) {

> -			if ((word & (1 << 31)) != oldbit) {
This needs to become:
			if (!!(word & (1 << 31)) != oldbit) {

so oldbit really get compared by bool and not by int.

> -				setmosi(spi, word & (1 << 31));
> -				oldbit = word & (1 << 31);
> -			}
> -		}
> +		if ((flags & SPI_MASTER_NO_TX) == 0)
> +			setmosi(spi, word & (1 << 31));
>  		spidelay(nsecs);	/* T(setup) */
>  
>  		setsck(spi, !cpol);
> @@ -81,18 +76,13 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
>  {
>  	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
>  
> -	bool oldbit = !(word & (1 << 31));
>  	/* clock starts at inactive polarity */
>  	for (word <<= (32 - bits); likely(bits); bits--) {
>  
>  		/* setup MSB (to slave) on leading edge */
>  		setsck(spi, !cpol);
> -		if ((flags & SPI_MASTER_NO_TX) == 0) {
> -			if ((word & (1 << 31)) != oldbit) {

and this needs to become:
			if (!!(word & (1 << 31)) != oldbit) {

> -				setmosi(spi, word & (1 << 31));
> -				oldbit = word & (1 << 31);
> -			}
> -		}
> +		if ((flags & SPI_MASTER_NO_TX) == 0)
> +			setmosi(spi, word & (1 << 31));
>  		spidelay(nsecs); /* T(setup) */
>  
>  		setsck(spi, cpol);


Sorry for the issue,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
