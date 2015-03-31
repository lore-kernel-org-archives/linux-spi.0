From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: bcm2835: add polling mode for transfers below
 30us
Date: Mon, 30 Mar 2015 21:28:38 -0600
Message-ID: <551A1466.2020706@wwwdotorg.org>
References: <808DC596-35BB-4A08-8CF4-DFAB6294636E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <808DC596-35BB-4A08-8CF4-DFAB6294636E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2015 08:03 AM, Martin Sperl wrote:
> In cases of short transfer times the CPU is spending lots of time
> in the interrupt handler and scheduler to reschedule the worker thread.
> 
> Measurements show that we have times where it takes 29.32us to between
> the last clock change and the time that the worker-thread is running again
> returning from wait_for_completion_timeout().
> 
> During this time the interrupt-handler is running calling complete()
> and then also the scheduler is rescheduling the worker thread.
> 
> This time can vary depending on how much of the code is still in
> CPU-caches, when there is a burst of spi transfers the subsequent delays
> are in the order of 25us, so the value of 30us seems reasonable.
> 
> With polling the whole transfer of 4 bytes at 10MHz finishes after 6.16us
> (CS down to up) with the real transfer (clock running) taking 3.56us.
> So the efficiency has much improved and also freeing CPU cycles, reducing
> interrupts and context switches.
> 
> Because of the above 30us seems to be a reasonable limit for polling.

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> @@ -204,6 +207,37 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,

> +	spi_used_hz = (cdiv) ? (clk_hz / cdiv) : (clk_hz / 65536);

"(cdiv)" can be just "cdiv".

> +	/* check if we shall run in polling mode */
> +	xfer_time_us = tfr->len * 9 * 1000000 / spi_used_hz;

Why 9 not 8; presumably thats bits per byte, and IIRC SPI doesn't have
anything like I2C's ack bit per byte?

> +	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US) {
...
> +			if ((bs->rx_len) && (time_after(jiffies, timeout))) {

There are many extra brackets here too.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
