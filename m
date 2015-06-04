From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
Date: Thu, 4 Jun 2015 06:21:32 +0200
Message-ID: <CAOMqctRkoQrP7wAgXfWXHb2fbi2-6VayHRx5DgUKn6Djz0qtQQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <201506040053.29482.marex@denx.de>
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
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@micron.com>, "grmoore@altera.c
To: Marek Vasut <marex@denx.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201506040053.29482.marex@denx.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4 June 2015 at 00:53, Marek Vasut <marex@denx.de> wrote:
> On Wednesday, June 03, 2015 at 11:26:39 PM, Michal Suchanek wrote:
>> Hello,
>
> Hi,
>
>> this patch series makes it possible to access the SPI NOR flash in the
>> Samsung XE303 'Snow' Chromebook.
>>
>> Unfortunately not all issues are resolved. To work around an issue with the
>> pl330 dma engine I respun the patch for limiting transfer size in m25p80
>> driver.
>
> Looks like fixing a bug at the wrong place to me ...
>
>> As the flash does not contain any sane filesystem and is only likely to be
>> accessed with mtd_debug or similar tool the limit of the dma engine is
>> easily reached. Filesystems using shorter data transfers are less likely
>> to be affected.
>
> Sounds like the DMA engine driver should be fixed.

I looked at the pl330 datasheet and don't see anything obviusly wrong
with the pl330 driver in Linux.

Ideally it would be fixed but I have no idea what's wrong with it.

Thanks

Michal
