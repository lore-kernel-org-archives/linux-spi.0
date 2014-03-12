From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: bitbang: fix shift for getmosi
Date: Wed, 12 Mar 2014 22:23:34 +0100
Message-ID: <20140312212334.GO3327@book.gsilab.sittig.org>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394637636-29042-2-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394637636-29042-2-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 16:20 +0100, Michael Grzeschik wrote:
> 
> The driver needs to shift the word bit after reading the mosi bit.
> Otherwise the return word will have an Off-by-one bit value.

The MISO gets read (is incoming), MOSI is outgoing.

> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Is the Cc: to stable@ appropriate without Fixes: or a version
that's supposed to be affected?  Has a bug been verified and are
you certain that the fix is correct?

> ---
>  drivers/spi/spi-bitbang-txrx.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
> index c616e41..b6e348d 100644
> --- a/drivers/spi/spi-bitbang-txrx.h
> +++ b/drivers/spi/spi-bitbang-txrx.h
> @@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  		spidelay(nsecs);
>  
>  		/* sample MSB (from slave) on leading edge */
> -		word <<= 1;
>  		if ((flags & SPI_MASTER_NO_RX) == 0)
>  			word |= getmiso(spi);
>  		setsck(spi, cpol);
> +		word <<= 1;
>  	}
>  	return word;
>  }

This seems wrong.  You might have observed an off by one error.
But this code change is suspicious.

Shifting first and ORing then makes the sample end up in the
lowest bit.  That's expected.

ORing the sample and shifting afterwards actually would be
creating an off by one error. :-O


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
