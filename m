From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
Date: Fri, 1 Aug 2014 19:06:17 -0700
Message-ID: <20140802020617.GS3711@ld-irv-0074>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
 <20140730050843.GE11952@brian-ubuntu>
 <20140730064413.GA15547@shldeISGChi005.sh.intel.com>
 <20140730074500.GF11952@brian-ubuntu>
 <20140730104607.GQ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <shijie.huang@intel.com>,
	Huang Shijie <b32955@freescale.com>, marex@denx.de,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140730104607.GQ17528@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 30, 2014 at 11:46:07AM +0100, Mark Brown wrote:
> On Wed, Jul 30, 2014 at 12:45:00AM -0700, Brian Norris wrote:
> > On Wed, Jul 30, 2014 at 02:44:13PM +0800, Huang Shijie wrote:
> > > IMHO, the DDR modes can _NOT_ be handled by the driver/spi/*.
> 
> > I agree to some extent, but I wanted to confirm with the SPI guys that
> > DDR is truly unique to SPI NOR. (I know it doesn't currently support
> > it.)
> 
> I don't know what DDR is in this context, sorry.

I think it's just the ability to latch data on both the rising and
falling edges of the SPI clock. For SPI flash, it seems to be used for
the data portion of the opcode/address/data sequence.

> I'm guessing you're
> right since it sounds like something to do with extra clocks and this is
> probably not something used by generic SPI devices at present (if it
> ends up being widely implemented by sufficiently generic controllers
> that might change but the trend seems to be to flash specific
> controllers).

OK, thanks for chiming in.

Yeah, I suppose it could be wedged in later if drivers/spi/ ever adopts
a solution.

Brian
