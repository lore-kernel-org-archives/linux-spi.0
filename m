From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 31 Mar 2015 07:51:43 +0200
Message-ID: <ECAA248A-EAF4-4B94-9905-9FD7D6DB48C9@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551A1185.6060502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 31.03.2015, at 05:16, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> I can understand perfectly why the code fills the FIFO before enabling
> interrupts; it avoids having to immediately service an interrupt simply
> to fill the FIFO.
> 
> However, I'm not sure why this is in any way related to whether the
> chip-select GPIO is valid. Surely we always want to do this? How does
> the mechanism used to control chip selects influence whether we want to
> pre-fill the FIFO?

During the time I was building a DMA only driver I saw "rare" glitches
in the CS line when using native CS. The "glitch" is that the CS drops
to inactive for a short period of time - typically 1 sample length at
10MHz sample rate, so <0.1us.

These "glitches" also once have been observed with the current driver
when using native-CS, so I think it is prudent to avoid native-CS when
enabling this optimization.

Hence this limitation or maybe even the full move to GPIO-CS for all.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
