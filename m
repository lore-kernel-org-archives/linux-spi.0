From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Handling clocks on external busses
Date: Mon, 4 Apr 2016 10:57:20 +0100
Message-ID: <20160404095720.GJ31814@localhost.localdomain>
References: <20151124173718.GK18889@ck-lbox>
 <20151202125855.GB6058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-i2c@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux@arm.linux.org.uk>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <broonie@kernel.org>, <wsa@the-dreams.de>
To: <linux-clk@vger.kernel.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151202125855.GB6058@localhost.localdomain>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 02, 2015 at 12:58:55PM +0000, Charles Keepax wrote:
> On Tue, Nov 24, 2015 at 05:37:18PM +0000, Charles Keepax wrote:
> > Hi,
> > 
> > When a clock driver is controlling a clock that is controlled
> > over I2C / SPI, we need to perform a write on that bus to enable
> > the clock. However, such busses often have their own clocks that
> > must be enabled. Since all clock prepares are controlled under
> > one large mutex this easily causes deadlock. The device is
> > waiting for the I2C / SPI write to complete and the I2C / SPI
> > driver is waiting for the clock prepare lock to be released so it
> > can enable its own clock.
> > 
> > I have had a bit of a search and it seems the only really advice
> > kicking about is that all I2C / SPI drivers should leave the
> > clock prepared all the time. Is that intended to be the long term
> > solution, should I treat not leaving the clock prepared as a bug?
> > 
> > Thanks,
> > Charles
> 
> Adding a few more people for visibility.
> 
> So after a bit more digging it seems this has been mitigated slightly
> as a lot of SPI driver have been updated to execute transfers in
> thread rather than from a worker thread and it seems the clock
> framework lets you re-enter the locked sections if called from the
> same thread.
> 
> I am looking at moving some (in mainline) clocking code into an actual
> clocking driver (for a SPI/I2C audio CODEC) but I am rather nervous
> about this causing problems for customers with random deadlocks.
> 
> I guess the naive solution looks like individual locks per clock, but
> from what I have been able to google it looks like there are some
> challenges with that approach, does anyone have any links to previous
> discussions on that? And any suggestions on how I might approach
> this?
> 
> Thanks,
> Charles

Hi guys,

Still struggling with this, basically the issue is that I need to
add a clock DT binding so a clock source can be user controlled.
But I can't find anyway to control a clock
that is behind a SPI interface reliably. Yes if the SPI transfer
gets executed in thread things work because of the re-entrant
clock locking, but when that doesn't happen and the SPI core punts
this to its worker thread things lock up. I also tried using
async SPI calls, which technically violates the requirement then
the clock is prepared before prepare returns although in our case
this doesn't really matter, but even that can potentially cause
issues as you have a potential mutex inversion (between the SPI
bus lock and the clock prepare lock).

How would we feel about just adding the clock binding at the
moment and parsing it manually to set the clock source? Then we
could add a proper clock driver once the locking is fixed in the
clock framework.

Thanks,
Charles
