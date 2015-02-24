From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 5/5] spi: dw: move to SPI core message handling
Date: Tue, 24 Feb 2015 14:58:58 +0200
Message-ID: <1424782738.14897.22.camel@linux.intel.com>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1424777534-14246-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424777534-14246-6-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-02-24 at 13:32 +0200, Andy Shevchenko wrote:
> This patch removes a lot of duplicate code since SPI core provides a nice
> message handling.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> -void dw_spi_xfer_done(struct dw_spi *dws)
> -{
> -	/* Update total byte transferred return count actual bytes read */
> -	dws->cur_msg->actual_length += dws->len;
> -
> -	/* Move to next transfer */
> -	dws->cur_msg->state = next_transfer(dws);
> -
> -	/* Handle end of message */
> -	if (dws->cur_msg->state == DONE_STATE) {
> -		dws->cur_msg->status = 0;
> -		giveback(dws);
> -	} else
> -		tasklet_schedule(&dws->pump_transfers);
> -}
> -EXPORT_SYMBOL_GPL(dw_spi_xfer_done);

This one should be removed from spi-dw.h as well.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
