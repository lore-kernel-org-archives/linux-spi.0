From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 08:43:02 +0200
Message-ID: <47A937D5-8520-471C-A164-198DFD7F68B3@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Now remembering a bit more from what I have observed:
> On 07.04.2015, at 08:25, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> 
> See also:
> http://www.raspberrypi.org/forums/viewtopic.php?f=44&t=19489&start=125#p451817
> for some observations mostly related to CLEAR_TX/CLEAR_RX that also
> de-assert CS for short periods.

Note that this TX/RX reset with native CS is also inhibiting the use
of DMA for any transfers not a multiple of 4 (DMA transfers data into
the FIFO in words not bytes). Because after those transfers we have
to reset the FIFO or the remaining bytes still in the FIFO will get
shifted out before a subsequent transfer.

So for any DMA enabled driver we need this kind of gpio-cs to avoid
this CS-glitch situation unless we want a "DMA only on multiple of 4"
with native-cs situation...

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
