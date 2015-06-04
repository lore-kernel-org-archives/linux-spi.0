From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 4 Jun 2015 10:31:45 +0200
Message-ID: <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	Marek Vasut <marex@denx.de>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4 June 2015 at 08:42, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jun 3, 2015 at 11:26 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>> On sunxi the SPI controller currently does not have DMA support and fails
>> any transfer larger than 63 bytes.
>
> This is a driver limitation, not a hardware limitation.
>
>> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
>> when using slower speed like 40MHz and any transfer larger than 128bytes
>> when running at 133MHz.
>
> This may be a driver bug.
>
>> The best thing is that in both cases the controller can just lock up and
>> never finish potentially leaving the hardware in unusable state.
>>
>> So it is required that the m25p80 driver actively prevents doing
>> transfers that are too large for the current driver state on a
>> particular piece of hardware.
>
> OK.
>

> DT describes the hardware, not buggy drivers.
>
> So IMHO this doesn't belong in DT, but it can be a field in struct spi_master.
>

Unfortunately, this cannot be a field in struct spi_master. The value
can and does vary with device configuration and device configuration
is only available in DT.

For example, on the Snow board one working configuration is

40MHz spi bus speed, feedback delay 0 and maximum transfer size 64k.

Another working configuration is 133MHz bus speed, feedback delay 3,
and maximum transfer size 128 bytes.

You might want to try to run the bus at 60MHz or 80MHz and then the
values would probably again be different.

The first two values are set in DT so the logical place for setting
the third is also in DT.

Otherwise you would need some in-kernel table of these settings.

Thanks

Michal
