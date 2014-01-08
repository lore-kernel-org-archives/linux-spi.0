From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: spi-rspi I/O errors
Date: Wed, 08 Jan 2014 01:27:15 +0100
Message-ID: <6231184.EMt0gDqh7K@avalon>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Tuesday 07 January 2014 21:27:18 Geert Uytterhoeven wrote:
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
> @@ -442,8 +442,13 @@ static int rspi_wait_for_interrupt(struct rspi_data
> *rspi, u8 wait_mask, rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
>  	rspi_enable_irq(rspi, enable_bit);
>  	ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask, HZ);
> -	if (ret == 0 && !(rspi->spsr & wait_mask))
> -		return -ETIMEDOUT;
> +	if (ret == 0 && !(rspi->spsr & wait_mask)) {
> +		u8 spsr = rspi_read8(rspi, RSPI_SPSR);
> +		printk("*** rspi->spsr = 0x%02x, real spsr = 0x%02x, wait_mask = 
0x%02x
> ***\n",
> +		       rspi->spsr, spsr, wait_mask);
> +		if (!(spsr & wait_mask))
> +			return -ETIMEDOUT;
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

What happens if you print rspi->spsr in the interrupt handler ? Does it have 
bit 7 set ?

> I didn't notice any data corruption after the patch.

-- 
Regards,

Laurent Pinchart

