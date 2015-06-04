From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 11:30:15 +0200
Message-ID: <CAMuHMdWHPm6exq4O3CNvVuiZOgLHuxyCrR548BFmbOPikvNRLw@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
	<305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
	<20150604091634.GY14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michal Suchanek <hramrach@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
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
	Han Xu <han.xu@freescale.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<b
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150604091634.GY14071@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 4, 2015 at 11:16 AM, Mark Brown <broonie@kernel.org> wrote:
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>
> Whatever you're doing here this indicates that there's a very big
> abstraction problem going on.

I guess it's needed for __clk_get_name(), which can be avoided by using
the "%pC" printf format specifier instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
