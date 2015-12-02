From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Handling clocks on external busses
Date: Wed, 2 Dec 2015 12:58:55 +0000
Message-ID: <20151202125855.GB6058@localhost.localdomain>
References: <20151124173718.GK18889@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	<sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151124173718.GK18889@ck-lbox>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Nov 24, 2015 at 05:37:18PM +0000, Charles Keepax wrote:
> Hi,
> 
> When a clock driver is controlling a clock that is controlled
> over I2C / SPI, we need to perform a write on that bus to enable
> the clock. However, such busses often have their own clocks that
> must be enabled. Since all clock prepares are controlled under
> one large mutex this easily causes deadlock. The device is
> waiting for the I2C / SPI write to complete and the I2C / SPI
> driver is waiting for the clock prepare lock to be released so it
> can enable its own clock.
> 
> I have had a bit of a search and it seems the only really advice
> kicking about is that all I2C / SPI drivers should leave the
> clock prepared all the time. Is that intended to be the long term
> solution, should I treat not leaving the clock prepared as a bug?
> 
> Thanks,
> Charles

Adding a few more people for visibility.

So after a bit more digging it seems this has been mitigated slightly
as a lot of SPI driver have been updated to execute transfers in
thread rather than from a worker thread and it seems the clock
framework lets you re-enter the locked sections if called from the
same thread.

I am looking at moving some (in mainline) clocking code into an actual
clocking driver (for a SPI/I2C audio CODEC) but I am rather nervous
about this causing problems for customers with random deadlocks.

I guess the naive solution looks like individual locks per clock, but
from what I have been able to google it looks like there are some
challenges with that approach, does anyone have any links to previous
discussions on that? And any suggestions on how I might approach
this?

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
