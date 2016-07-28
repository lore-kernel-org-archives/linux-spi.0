From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 28 Jul 2016 15:40:45 -0400
Message-ID: <20160728194045.GK15995@brightrain.aerifal.cx>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160728191153.GL11806@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 28, 2016 at 08:11:53PM +0100, Mark Brown wrote:
> On Sun, Apr 03, 2016 at 05:12:45AM +0000, Rich Felker wrote:
> 
> > +config SPI_JCORE
> > +	tristate "J-Core SPI Master"
> > +	depends on OF
> > +
> 
> An architecture or SoC dependency with || COMPILE_TEST would be useful
> for avoiding cluttering Kconfig for other users.  Though as this is in a
> FPGA it's perhaps likely people will pick this up for other FPGAs so
> perhaps a comment to that effect if it seems likely.

Unlike some of the other SoC hardware (interrupt controller) that's
more closely tied to the SH cpu trap behavior, the SPI master seems
like something that would be nice and easy to reuse elsewhere. I don't
feel strongly about it either way though; I can add the arch dep if
you want.

> > +static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
> > +{
> > +	if (speed == hw->speed_hz) return;
> > +	hw->speed_hz = speed;
> > +	if (speed >= hw->clock_freq/2)
> 
> Coding style, spaces around /.

OK.

> > +	return count<len ? -EREMOTEIO : 0;
> 
> Again here, and please also write this as a normal if statement so it's
> easier to read.

OK.

> > +	/* The SPI clock rate controlled via a configurable clock divider
> > +	 * which is applied to the reference clock. A 50 MHz reference is
> > +	 * most suitable for obtaining standard SPI clock rates, but some
> > +	 * designs may have a different reference clock, and the DT must
> > +	 * make the driver aware so that it can properly program the
> > +	 * requested rate. If omitted, 50 MHz is assumed. */
> > +	clock_freq = 50000000;
> > +	of_property_read_u32(node, "clock-frequency", &clock_freq);
> > +	hw->clock_freq = clock_freq;
> 
> Why are you not using the clock API for this?  Just require a clock and
> use clk_get_rate() to find out what rate it is.

I thought about that but I'm not familiar with it. I can try to figure
it out quickly and test that approach; don't see any reason it
shouldn't work. Would you insist on having full support for
enabling/disabling the clk when it's in use, or would you be happy
with treating it as a fixed clock that's always-on for now and
possibly extending it with more functionality later if there's ever
hardware where that's relevant/helpful?

> > +	pdev->dev.dma_mask = 0;
> 
> Why are we doing this?  There's no DMA code...

There will be later, but I can remove this for now if it's not needed.

> > +	dev_info(&pdev->dev, "base %p, noirq\n", hw->base);
> 
> This is just adding noise to the boot, just remove it - it's useful to
> log information we get from the silicon but things like the base address
> don't really add anything and end up cluttering (and slowing) the boot
> when everything does it.

OK.

Rich
