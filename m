From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Wed, 15 Jul 2015 13:52:27 +0200
Message-ID: <201507151352.27689.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <20150604171547.GA1530@localhost.localdomain> <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Richard Cochran <richardcochran@gmail.com>,
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
	Mark Brown <broonie@kernel.org>,
	Dan
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, July 15, 2015 at 11:45:07 AM, Michal Suchanek wrote:
> On 4 June 2015 at 19:15, Richard Cochran <richardcochran@gmail.com> wrote:
> > On Thu, Jun 04, 2015 at 10:31:45AM +0200, Michal Suchanek wrote:
> >> You might want to try to run the bus at 60MHz or 80MHz and then the
> >> values would probably again be different.
> >> 
> >> The first two values are set in DT so the logical place for setting
> >> the third is also in DT.
> >> 
> >> Otherwise you would need some in-kernel table of these settings.
> > 
> > Or a formula.
> 
> This formula probably needs to take into account
> 
>  - the unknown reason for the pl330 to fail transfer

Shouldn't that be fixed at the PL330 level ? This looks like fixing
a problem at the wrong place :)

>  - the device transfer speed and transfer phase as set in DT
>  - possibly device-specific latency and board-specific trace design
> and assembly tolerances

If the design is broken, then cap the speed as for normal SPI device.

> Seriously, until I have at least a vague idea why the transfer fails I
> am not comfortable pulling some formula out of thin air and pretending
> I have a working patch.
> 
> On the other hand, a parameter you can set in the DT and which comes
> with a suggested value which can be tuned depending on the system
> seems more viable.

The problem is, if you add a new DT binding, you'd have to support it
forever, no matter how bad idea that binding turned out to be.

Best regards,
Marek Vasut
