From: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Subject: Re: Re: spi-atmel: scheduling while atomic
Date: Fri, 11 Apr 2014 23:11:29 +0200
Message-ID: <2776532.qUm2PuCHHs@kongar>
References: <1734135.RAAc8zgbc4@kongar> <20140411162223.GG28800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140411162223.GG28800-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday 11 April 2014, 17:22:23 wrote Mark Brown:
> On Fri, Apr 11, 2014 at 03:25:43PM +0200, Alexander Stein wrote:
> 
> > Currently, I can't figure out why this happens. It's a plain v3.14
> > kernel with some own patches which don't affect SPI.
> 
> It's because atmel_spi_lock() is a spinlock and we're waiting for the
> transfer in transfer_one().  Either the scope of the lock needs to be
> dramatically reduced or the lock needs to become something we can hold
> while scheduling like a mutex.

Mh, this seems to related to DMA. I don't have an idea how to work an that.

> Converting to use the core transfer_one_message() would also help, we
> could then return from the transfer function and have the core implement
> the wait for the completion.

Mh, this driver already uses that.
> master->transfer_one_message = atmel_spi_transfer_one_message;

Or did you mean transfer_one?

Regards,
Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
