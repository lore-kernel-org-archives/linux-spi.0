From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Thu, 26 Dec 2013 12:42:58 +0100
Message-ID: <20131226114258.GH8064@book.gsilab.sittig.org>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 26, 2013 at 09:00 +0200, Baruch Siach wrote:
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index c3354e8..4e01019 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -427,7 +427,6 @@ static void pump_transfers(unsigned long data)
>  	dws->tx_end = dws->tx + transfer->len;
>  	dws->rx = transfer->rx_buf;
>  	dws->rx_end = dws->rx + transfer->len;
> -	dws->cs_change = transfer->cs_change;
>  	dws->len = dws->cur_transfer->len;
>  	if (chip != dws->prev_chip)
>  		cs_change = 1;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 1ccfc18..cb52cfe 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -135,7 +135,6 @@ struct dw_spi {
>  	u8			n_bytes;	/* current is a 1/2 bytes op */
>  	u8			max_bits_per_word;	/* maxim is 16b */
>  	u32			dma_width;
> -	int			cs_change;
>  	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
>  	void			(*cs_control)(u32 command);
>  
> -- 

This looks suspicious.  Are you (the driver) ignoring the
cs_change information which the caller (the code which emits the
SPI message transfer call) provides?  This appears to be a
deficiency in the SPI master's code then.  Callers should be able
to control CS behaviour between the partial transfers of an SPI
message.  It's part of the API.

While you are checking whether the SPI master obeys the caller's
CS change spec, can you check the optional delay between partial
transfers as well (I assume that both get handled in the same
spots of the code path)?  ISTR that these two aspects (and the
lack of GPIO backed chip selects given how the hardware CS line
acts) were real obstacles when trying to use this DW SPI master.

Thank you for looking at it (and for having GPIO CS lines in your
queue, which would unbreak the worst blocker)!


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
