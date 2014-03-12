From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Wed, 12 Mar 2014 22:29:41 +0100
Message-ID: <20140312212941.GP3327@book.gsilab.sittig.org>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394637636-29042-3-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394637636-29042-3-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 16:20 +0100, Michael Grzeschik wrote:
> 
> The bitbang spi driver currently only supports the MSB mode. This patch
> adds the possibility to clock the data in LSB mode.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/spi/spi-bitbang-txrx.h | 98 +++++++++++++++++++++++++++++-------------
>  drivers/spi/spi-bitbang.c      |  3 +-
>  2 files changed, 71 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
> index b6e348d..7f9c020 100644
> --- a/drivers/spi/spi-bitbang-txrx.h
> +++ b/drivers/spi/spi-bitbang-txrx.h
> @@ -49,22 +49,42 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  {
>  	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
>  
> -	/* clock starts at inactive polarity */
> -	for (word <<= (32 - bits); likely(bits); bits--) {
> -
> -		/* setup MSB (to slave) on trailing edge */
> -		if ((flags & SPI_MASTER_NO_TX) == 0)
> -			setmosi(spi, word & (1 << 31));
> -		spidelay(nsecs);	/* T(setup) */
> -
> -		setsck(spi, !cpol);
> -		spidelay(nsecs);
> -
> -		/* sample MSB (from slave) on leading edge */
> -		if ((flags & SPI_MASTER_NO_RX) == 0)
> -			word |= getmiso(spi);
> -		setsck(spi, cpol);
> -		word <<= 1;
> +	if (spi->mode & SPI_LSB_FIRST) {
> +		/* clock starts at inactive polarity */
> +		for (; likely(bits); bits--) {
> +
> +			/* setup MSB (to slave) on trailing edge */
> +			if ((flags & SPI_MASTER_NO_TX) == 0)
> +				setmosi(spi, word & 1);
> +			spidelay(nsecs);	/* T(setup) */
> +
> +			setsck(spi, !cpol);
> +			spidelay(nsecs);
> +
> +			/* sample LSB (from slave) on leading edge */
> +			if ((flags & SPI_MASTER_NO_RX) == 0)
> +				word |= getmiso(spi);
> +			setsck(spi, cpol);
> +			word >>= 1;
> +		}
> +	} else {
> +		/* clock starts at inactive polarity */
> +		for (word <<= (32 - bits); likely(bits); bits--) {
> +
> +			/* setup MSB (to slave) on trailing edge */
> +			if ((flags & SPI_MASTER_NO_TX) == 0)
> +				setmosi(spi, word & (1 << 31));
> +			spidelay(nsecs);        /* T(setup) */
> +
> +			setsck(spi, !cpol);
> +			spidelay(nsecs);
> +
> +			/* sample MSB (from slave) on leading edge */
> +			if ((flags & SPI_MASTER_NO_RX) == 0)
> +				word |= getmiso(spi);
> +			setsck(spi, cpol);
> +			word <<= 1;
> +		}
>  	}
>  	return word;
>  }

Would it be useful to not duplicate the transmission logic, but
instead to optionally "bit swap" the TX and RX data before and
after the common transmission logic?  Just a though whether this
might help maintenance.  There might even be existing and proven
code to bit swap integers?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
