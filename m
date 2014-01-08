From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: spi-rspi I/O errors
Date: Wed, 8 Jan 2014 09:28:46 +0900
Message-ID: <20140108002846.GF5136@verge.net.au>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1401072116370.27579-97SZ98TBZzA1xEWliksxXw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 07, 2014 at 09:27:18PM +0100, Geert Uytterhoeven wrote:
> I was regularly getting I/O errors when using the Renesas RSPI/QSPI
> driver on r8a7791:
> 
>     m25p80 spi0.0: error -110 reading SR
> 
> Until I applied the following patch, which re-reads RSPI_SPSR on a time-out,
> and continues if the condition has become true:
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 4b31d89e8568..e63e30c500da 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -442,8 +442,13 @@ static int rspi_wait_for_interrupt(struct rspi_data *rspi, u8 wait_mask,
>  	rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
>  	rspi_enable_irq(rspi, enable_bit);
>  	ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask, HZ);
> -	if (ret == 0 && !(rspi->spsr & wait_mask))
> -		return -ETIMEDOUT;
> +	if (ret == 0 && !(rspi->spsr & wait_mask)) {
> +		u8 spsr = rspi_read8(rspi, RSPI_SPSR);
> +		printk("*** rspi->spsr = 0x%02x, real spsr = 0x%02x, wait_mask = 0x%02x ***\n",
> +		       rspi->spsr, spsr, wait_mask);
> +		if (!(spsr & wait_mask))
> +			return -ETIMEDOUT;

I'm entirely unsure if this is the right approach,
but if it is should rspi->spsr = spsr go somewhere around here?

> +	}
>  
>  	return 0;
>  }
> 
> Now it prints from time to time:
> 
>     *** rspi->spsr = 0x20, real spsr = 0xa0, wait_mask = 0x80 ***
> 
> which shows that rspi->spsr (as set from the interrupt handler) didn't
> have bit 7 set, while RSPI_SPSR does have bit 7 set.
> 
> So this looks like a race condition in the interrupt handling.
> 
> I didn't notice any data corruption after the patch.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
