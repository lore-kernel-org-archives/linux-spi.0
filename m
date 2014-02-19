From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: [PATCH 1/3] spi-topcliff-pch: Transform noisy message to dev_dbg
Date: Wed, 19 Feb 2014 18:23:53 +0100
Message-ID: <2419893.gRRecuQuqc@ws-stein>
References: <1392802569-11148-1-git-send-email-alexander.stein@systec-electronic.com> <20140219124150.GO2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219124150.GO2669-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On Wednesday 19 February 2014 21:41:50, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 10:36:07AM +0100, Alexander Stein wrote:
> > If during a SPI transfer with len larger than PCH_MAX_FIFO_DEPTH and the
> > IRQ handler happens to be called when the transmit FIFO is already empty,
> > and SPSR_FI_BIT is set consequently, the message
> > "spi_master spi32766: pch_spi_handler_sub : Transfer is not completed"
> > is spammed to the systemlog, because tx_index has already increased
> > further due to the next bytes to be written. This case is uncritical as
> > new bytes have already been written.
> 
> When you say "spammed" does that mean "printed once" or "is continually
> printed"?  I'd have assumed the latter in which case it might be better
> to go as low as _vdbg() or even remove the message entirely if it's not
> possible to suppress it entirely.

It is printed continually during the whole SPI transfer, e.g. dumping a 256k AT25 EEPROM.
I don't know this hardware good enough to judge if it can be suppressed at all. Maybe if the interrupt thresholds are appropriately this doesn't happen. But maybe if someone changes that, maybe this driver can be changed to a queued driver instead which could simplify the driver.

Best regards,
Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
