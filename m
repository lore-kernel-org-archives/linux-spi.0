From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: fix spurious i/o error
Date: Tue, 24 Nov 2015 17:57:26 +0530
Message-ID: <565457AE.3050309@ti.com>
References: <108883742c4b44d338ea0816abeeb2901a2afcd5.1448361028.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <108883742c4b44d338ea0816abeeb2901a2afcd5.1448361028.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 24 November 2015 04:04 PM, Sekhar Nori wrote:
> davinci_spi_bufs() uses wait_for_completion_interruptible()
> without bothering to handle -ERESTARTSYS. Due to this,
> sometime, it returns prematurely when a signal is received.
> Since the return value is never checked, userspace eventually
> receives a spurious -EIO.
> 
> To fix this, use un-interruptible wait_for_completion_timeout().
> 
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/spi/spi-davinci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 7d3af3eacf57..38026aa1afd7 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -703,7 +703,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
>  
>  	/* Wait for the transfer to complete */
>  	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
> -		wait_for_completion_interruptible(&(dspi->done));
> +		if (wait_for_completion_timeout(&dspi->done, HZ) == 0) {
> +			dev_err(&spi->dev, "spi transfer timeout\n");
> +			return -ETIMEDOUT;

Grygorii pointed out offline that this does not recover correctly in DMA
case. I will fix and send a v2.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
