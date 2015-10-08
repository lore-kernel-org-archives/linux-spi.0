From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: McSPI hangs with cs_change after "Switch driver to use
 transfer_one" change
Date: Thu, 8 Oct 2015 09:47:11 -0500
Message-ID: <20151008144711.GA8072@deathstar>
References: <561675AA.4010505@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561675AA.4010505-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Oct 08, 2015 at 02:54:50PM +0100, Neil Armstrong wrote:
> Hi All,
> 
> I'm in a use case where I use cs_change on McSPI channel 3 on a single transfer Full-Duplex message, then I transfer a single full duplex message without cs_change on channel 1.
> 
> Here is a better representation :
> -- 1 transfer message cs_change=1
> cs3 : set_cs(0)
> cs3 : full-duplex transfer
> cs3 : transfer ok
> -- 1 transfer message cs_change=1
> cs3 : set_cs(0)
> cs3 : full-duplex transfer
> cs3 : transfer ok
> ...
> -- 1 transfer message cs_change=1
> cs3 : set_cs(0)
> cs3 : full-duplex transfer
> cs3 : transfer ok
> -- 1 transfer message cs_change=1
> cs1 : set_cs(0)

Looks like bus contention here.

> cs1 : full-duplex transfer
> cs1 : RXS timed out
> cs1 : set_cs(1)
> 
> Then "RXS timed out" on each non-cs3 transfers.
> 
> The previous behavior of cs_change was :
> - between transfers, unassert CS and re-assert-it for the following transfer
> - between messages, unassert CS
> 
> The new behaviour inherited from the SPI core spi_transfer_one_message function :
> - between transfers, unassert CS and re-assert-it for the following transfer
> - between messages, leave CS asserted
> 
> We tried disabling the DMA, and the FIFO, but the behavior was actually the same, only reverting back before the "Switch driver to use transfer_one" fixed the issue.
> 
> Then actually disabling the cs_change corrected the issue. It may be why the original driver ignored the "leave it on after last xfer" hint.
> 
> The problem is : how can we disable this hint since it is managed in SPI core spi_transfer_one_message ?

It seems the core driver assumes that the driver is smart enough to deselect
the previous chip select instead of doing it explicitly.

> 
> A solution will be to track down the current asserted CS and unassert it them when the active channel changes.
> 
> Neil
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
