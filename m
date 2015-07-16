From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 16 Jul 2015 03:44:56 +0200
Message-ID: <201507160344.56393.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <201507151915.50677.marex@denx.de> <20150716011935.GB9033@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: hramrach@gmail.com, Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= (beanhuo)"
	<beanhuo@micron.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Vinod Koul <vinod.koul@intel.com>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Brown <broon
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150716011935.GB9033@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, July 16, 2015 at 03:19:35 AM, Brian Norris wrote:
> On Wed, Jul 15, 2015 at 07:15:50PM +0200, Marek Vasut wrote:
> > On Wednesday, July 15, 2015 at 05:59:46 PM, Brian Norris wrote:
> > > 1. Fix up the SPI driver so that it knows how to break large SPI
> > > transfers up into smaller segments that its constituent hardware (DMA
> > > controllers, fast clocks, etc.) can handle.
> 
> BTW, Mark Brown already commented on this approach:
> 
> http://lists.infradead.org/pipermail/linux-mtd/2015-May/059364.html
> 
> I quote:
> | With modern drivers using transfer_one() where we have control of the
> | chip select we do also have the ability to add support to the core for
> | chopping large transfers up into smaller ones that the hardware can
> | handle transparently.  That won't for everything though since it depends
> | on us being able to manually control the chip select which not all
> | hardware can do.
> | 
> > I think this might actually be easier -- just do a transfer where you
> > don't toggle CS and just stops the clock at the last bit, then do another
> > (multiple) transfers which don't toggle CS at all, then finally do a
> > transfer which toggles a CS at the end.
> 
> Sounds OK to me. And as Mark noted, this could probably be done in the
> core. I suppose Mark could suggest whether the most expedient path is to
> hack the buggy driver to do this, or whether reworking the SPI core to
> have the appropriate spi_master field(s) (and caveats) to support this.

Yep, agreed.

> > This should be pretty trivial
> > to do and I think for example spi-mxs.c does this.
> 
> I don't think spi-mxs.c really does this; it chooses between PIO and DMA
> based on length, but with either option, it runs through each SPI
> transfer in one go. You might be confused by the fact that this driver
> implements ->transfer_one_message instead of ->transfer_one, so it has
> to loop through all transfers in the message.

It does chop up the DMA transfers between multiple runs of the DMA engine
IIRC. But it does so within the driver, which apparently is not the way
to go :)

> (IIUC, spi-mxs.c could easily be rewritten to use ->transfer, and some
> of that not-too-complicated boilerplate could be killed off.)

Most likely, yes.

Best regards,
Marek Vasut
