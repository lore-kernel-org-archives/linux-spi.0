From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 4 Jun 2015 17:15:12 +0200
Message-ID: <201506041715.12904.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <201506040103.09555.marex@denx.de> <CAOMqctQeg0Sj1pGOQsK1nNB6=-H9koH_5nrXYBq_NKeVt369dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Han Xu <han.xu@freescale.com>, Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= (beanhuo)"
	<beanhuo@micron.com>, "grmoo
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMqctQeg0Sj1pGOQsK1nNB6=-H9koH_5nrXYBq_NKeVt369dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, June 04, 2015 at 06:31:45 AM, Michal Suchanek wrote:
> On 4 June 2015 at 01:03, Marek Vasut <marex@denx.de> wrote:
> > On Wednesday, June 03, 2015 at 11:26:41 PM, Michal Suchanek wrote:
> >> On sunxi the SPI controller currently does not have DMA support and
> >> fails any transfer larger than 63 bytes.
> >> 
> >> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
> >> when using slower speed like 40MHz and any transfer larger than 128bytes
> >> when running at 133MHz.
> > 
> > This smells more like some corruption of the data on the bus or something
> > even more obscure.
> 
> If the data was corrupted you would get corrupted data and not
> transfer failure. AFAIK there is no checksum or anything. I actually
> do get corrupted data when I use wrong feedback delay setting.

OK

> >> The best thing is that in both cases the controller can just lock up and
> >> never finish potentially leaving the hardware in unusable state.

[...]

> >> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> 
> >> @@ -19,6 +19,12 @@ Optional properties:
> >>                     all chips and support for it can not be detected at
> >> 
> >> runtime. Refer to your chips' datasheet to check if this is supported by
> >> your chip.
> >> +- linux,max_tx_len : With some SPI controller drivers possible transfer
> >> size is +                     limited. This may be hardware or driver
> >> bug. +                     Transfer data in chunks no larger than this
> >> value. +
> >> 
> >>                     Using this option may severely degrade performance
> >>                     and
> >> 
> >> +                     possibly flash memory life when max_tx_len is
> >> smaller than +                     flash page size (typically 256 bytes)
> > 
> > Will we need similar patch for all other SPI slave drivers, like SPI NAND
> > ?
> 
> Probably. Some SPI slave drivers already do have similar option.

So the SPI device drivers are implementing workarounds for buggy SPI hosts,
even if those SPI devices themselves don't suffer from such limitations. Yes,
this seems like the seriously wrong thing to do.

> In general it cannot be expected that you can reliably transfer
> arbitrarily large data over SPI it seems.

This is what should be expected because this is how the bus is supposed
to work in fact. You can transfer an arbitrary amount of data over SPI
bus.

If some driver has a limitation, it's that (bus, dma) driver which needs
to implement a fix or a workaround.

> However, if the nand driver transfers data a page at a time it should
> be fine.

... until someone issues multi-block read, in which case it all falls
down like a house of cards. It is impossible to build a reliable system
on "should" and similar assumptions ; the driver must be solid.

Best regards,
Marek Vasut
