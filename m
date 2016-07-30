From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Fri, 29 Jul 2016 23:34:41 -0400
Message-ID: <20160730033441.GO15995@brightrain.aerifal.cx>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160728195125.GN11806@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 28, 2016 at 08:51:25PM +0100, Mark Brown wrote:
> On Thu, Jul 28, 2016 at 03:40:45PM -0400, Rich Felker wrote:
> > On Thu, Jul 28, 2016 at 08:11:53PM +0100, Mark Brown wrote:
> 
> > > An architecture or SoC dependency with || COMPILE_TEST would be useful
> > > for avoiding cluttering Kconfig for other users.  Though as this is in a
> > > FPGA it's perhaps likely people will pick this up for other FPGAs so
> > > perhaps a comment to that effect if it seems likely.
> 
> > Unlike some of the other SoC hardware (interrupt controller) that's
> > more closely tied to the SH cpu trap behavior, the SPI master seems
> > like something that would be nice and easy to reuse elsewhere. I don't
> > feel strongly about it either way though; I can add the arch dep if
> > you want.
> 
> I guess it depends if anyone is actually doing that or not, if nobody is
> the dependency would be better.

OK, let's add the dependency for now with the intent to remove it
if/when there's a need.

> > > Why are you not using the clock API for this?  Just require a clock and
> > > use clk_get_rate() to find out what rate it is.
> 
> > I thought about that but I'm not familiar with it. I can try to figure
> > it out quickly and test that approach; don't see any reason it
> > shouldn't work. Would you insist on having full support for
> > enabling/disabling the clk when it's in use, or would you be happy
> > with treating it as a fixed clock that's always-on for now and
> > possibly extending it with more functionality later if there's ever
> > hardware where that's relevant/helpful?
> 
> It's fine to just enable it at startup and leave it on, though the
> runtime PM ops are trivial and you can set auto_runtime_pm to have the
> core do the gets and puts.

I was able to get it working via the clk api and I'll include support
for this in the next version of the patch, but to actually use it
depends on changing arch/sh to use the common clk framework; otherwise
there's no way to provide a suitable clk in the DT and have
[devm_]clk_get actually pick it up. Should I keep around the option of
using clock-frequency too? That would be most convenient.

I do have a pending patch from Sato-san to switch arch/sh over to CCF
but it's part of a series and I don't think it's ready to merge. I may
be able to merge just a minimal, safe subset that won't break legacy
non-DT configurations, though.

Rich
