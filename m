From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 4 Aug 2016 13:03:02 -0400
Message-ID: <20160804170301.GJ15995@brightrain.aerifal.cx>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk>
 <20160730033441.GO15995@brightrain.aerifal.cx>
 <CAMuHMdURxKP_U649yWPtmyQBh+zasUBDYcK5YKD0eL4MuXVs0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdURxKP_U649yWPtmyQBh+zasUBDYcK5YKD0eL4MuXVs0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 04, 2016 at 03:05:16PM +0200, Geert Uytterhoeven wrote:
> Hi Rich,
> 
> On Sat, Jul 30, 2016 at 5:34 AM, Rich Felker <dalias@libc.org> wrote:
> > On Thu, Jul 28, 2016 at 08:51:25PM +0100, Mark Brown wrote:
> >> On Thu, Jul 28, 2016 at 03:40:45PM -0400, Rich Felker wrote:
> >> > On Thu, Jul 28, 2016 at 08:11:53PM +0100, Mark Brown wrote:
> >> > > Why are you not using the clock API for this?  Just require a clock and
> >> > > use clk_get_rate() to find out what rate it is.
> >>
> >> > I thought about that but I'm not familiar with it. I can try to figure
> >> > it out quickly and test that approach; don't see any reason it
> >> > shouldn't work. Would you insist on having full support for
> >> > enabling/disabling the clk when it's in use, or would you be happy
> >> > with treating it as a fixed clock that's always-on for now and
> >> > possibly extending it with more functionality later if there's ever
> >> > hardware where that's relevant/helpful?
> >>
> >> It's fine to just enable it at startup and leave it on, though the
> >> runtime PM ops are trivial and you can set auto_runtime_pm to have the
> >> core do the gets and puts.
> >
> > I was able to get it working via the clk api and I'll include support
> > for this in the next version of the patch, but to actually use it
> > depends on changing arch/sh to use the common clk framework; otherwise
> > there's no way to provide a suitable clk in the DT and have
> > [devm_]clk_get actually pick it up. Should I keep around the option of
> > using clock-frequency too? That would be most convenient.
> >
> > I do have a pending patch from Sato-san to switch arch/sh over to CCF
> > but it's part of a series and I don't think it's ready to merge. I may
> > be able to merge just a minimal, safe subset that won't break legacy
> > non-DT configurations, though.
> 
> I think you can use non-CCF clocks with DT, if you register them first.
> Cfr. the clk_names[] array and shmobile_clk_workaround() function in
> v3.18:arch/arm/mach-shmobile/board-koelsch-reference.c and
> v3.18:arch/arm/mach-shmobile/clock.c
> 
> Or was that the other way around?

You can, but they will only be registered if a board file or
equivalent registers them. The intent is not to have any board files
for boards supported through device tree and eventually to remove all
the board files from arch/sh.

Rich
