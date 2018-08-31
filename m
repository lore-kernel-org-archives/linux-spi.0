From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date: Fri, 31 Aug 2018 16:38:56 +0800
Message-ID: <CAMz4kuJp=tBPubM1cWJLLMq4vRvK=-xcsH3GC5io6heQh4RG6w@mail.gmail.com>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
 <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 29 August 2018 at 19:33, Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> wrote:
> On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
>>
>> + * @word_delay: clock cycles to inter word delay after each word size
>> + *     (set by bits_per_word) transmission.
>
>
> I need a similar functionality for talking to a SPI device from userspace
> -- see my attempt for implementing this in spi-orion.c at [1]. The device=
's
> datasheet says that I should wait, e.g., 3=C2=B5s between each two words.=
 I
> therefore like this patch :).
>
> The description can be improved because it left me wondering what "clock
> this is about. I suppose it's about the SPI clock cycles and not CPU cloc=
k
> cycles, right? I'll be hapy to patch this once Baolin confirms that that =
is
> the intended meaning.

Sorry for confusing. Since our SPI word delay unit is clock cycle of
the SPI clock, so my intention of the word_delay's unit is SPI clock
cycles according to our previous discussion.

>
> It seems that this is only implemented in one newly added driver. I'm
> interested in supporting this in spi-orion.c, but that sounds like
> driver-specific work for something which is pretty generic. How should th=
is
> be implemented? Given that drivers for SPI masters can implement a functi=
on
> which transfers several words at once, there are not that many better
> possibilities than adding udelay()s, though. Thoughts?
>
> What is your plan to do with drivers which do not implement this (yet)? I=
f a
> spi_transfer gets queued which asks for a word_delay delay, it is silentl=
y
> ignored now, AFAIU.
>
> What about userspace support, spidev and spi_ioc_transfer (that's my targ=
et,
> actually)? Is it OK to s/pad/word_delay/ in the spidev code and pass that=
 to
> the generated struct spi_transfer? In my opinion, once we support specify=
ing
> this from userspace, one has to definitely check that the SPI controller =
is
> ready to honor this request. Do we want a new bit in spi_controller.flags
> for this?
>
> With kind regards,
> Jan
>
> [1] https://patchwork.kernel.org/patch/10221397/



--=20
Baolin Wang
Best Regards
