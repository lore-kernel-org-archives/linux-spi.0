From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Wed, 15 Jul 2015 19:15:50 +0200
Message-ID: <201507151915.50677.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <201507151352.27689.marex@denx.de> <20150715155946.GB21362@localhost>
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
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150715155946.GB21362@localhost>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, July 15, 2015 at 05:59:46 PM, Brian Norris wrote:
> Hi Michal,

Hi all,

> On Wed, Jul 15, 2015 at 01:52:27PM +0200, Marek Vasut wrote:
> > The problem is, if you add a new DT binding, you'd have to support it
> > forever, no matter how bad idea that binding turned out to be.
> 
> Agreed, and a solid NAK to this patch. I could have sworn I gave such a
> response when this was originally being discussed a month ago.
> 
> AFAICT, you have one of two general approaches available to you:
> 
> 1. Fix up the SPI driver so that it knows how to break large SPI
> transfers up into smaller segments that its constituent hardware (DMA
> controllers, fast clocks, etc.) can handle.

I think this might actually be easier -- just do a transfer where you
don't toggle CS and just stops the clock at the last bit, then do another
(multiple) transfers which don't toggle CS at all, then finally do a
transfer which toggles a CS at the end. This should be pretty trivial
to do and I think for example spi-mxs.c does this.

Best regards,
Marek Vasut
