From: Padma Venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Date: Mon, 10 Nov 2014 10:20:27 +0530
Message-ID: <CAAgF-Bd=S7-PoA7GZoy87W9Dem3OXVhc1tL-eyWEAHvF0LPTKQ@mail.gmail.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
	<20141106102636.GT8509@sirena.org.uk>
	<CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
	<20141107101310.GA8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141107101310.GA8509@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 11/7/14, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Nov 07, 2014 at 02:01:57PM +0530, Padma Venkat wrote:
>
>> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
>> in CS_CFG. When it is auto CS automatically toggles between packet to
>> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
>> driver by default uses manual mode. But on exynos7 the manual mode is
>> removed.
>
> OK, but what's a packet here?

Packet is either 1 byte or 4 bytes size depends on width of the SPI channel.

>
>> I tested the driver with wm5110 codec.
>
> Did you try firmware downloads or something else that generates multiple
> transfers in a message?  Normal register writes will use a single
> transfer so I'd expect them to just work.
>

OK. I don't have provision to test on this board. I will try to test
on older boards by disabling manual mode.

Thanks
padma
