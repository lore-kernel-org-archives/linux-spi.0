From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date: Wed, 29 Aug 2018 13:33:24 +0200
Message-ID: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <orsonzhai@gmail.com>, <zhang.lyra@gmail.com>,
        <lanqing.liu@spreadtrum.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
> + * @word_delay: clock cycles to inter word delay after each word size
> + *=09(set by bits_per_word) transmission.

I need a similar functionality for talking to a SPI device from userspace =20=

-- see my attempt for implementing this in spi-orion.c at [1]. The device's=20=

datasheet says that I should wait, e.g., 3=C2=B5s between each two words. I=20=

therefore like this patch :).

The description can be improved because it left me wondering what "clock=20
this is about. I suppose it's about the SPI clock cycles and not CPU clock=20=

cycles, right? I'll be hapy to patch this once Baolin confirms that that is=20=

the intended meaning.

It seems that this is only implemented in one newly added driver. I'm=20
interested in supporting this in spi-orion.c, but that sounds like=20
driver-specific work for something which is pretty generic. How should this=20=

be implemented? Given that drivers for SPI masters can implement a function=20=

which transfers several words at once, there are not that many better=20
possibilities than adding udelay()s, though. Thoughts?

What is your plan to do with drivers which do not implement this (yet)? If=20=

a spi_transfer gets queued which asks for a word_delay delay, it is=20
silently ignored now, AFAIU.

What about userspace support, spidev and spi_ioc_transfer (that's my=20
target, actually)? Is it OK to s/pad/word_delay/ in the spidev code and=20
pass that to the generated struct spi_transfer? In my opinion, once we=20
support specifying this from userspace, one has to definitely check that=20
the SPI controller is ready to honor this request. Do we want a new bit in=20=

spi_controller.flags for this?

With kind regards,
Jan

[1] https://patchwork.kernel.org/patch/10221397/
