From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date: Mon, 30 Jul 2018 11:39:07 +0300
Message-ID: <CAHp75VdrpOkonozNRUCzchsNHbgV=djecVDr0-fRiYAa4iDE0A@mail.gmail.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <1532624495.2283.197.camel@impinj.com> <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?=
        <hayashi.kunihiko@socionext.com>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?=
        <yamada.masahiro@socionext.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 30, 2018 at 8:30 AM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:
> Hello Trent and Andy,

>> > > +       ckrat = roundup(ckrat, 2);
>> >
>> > ckrat += ckrat & 1;
>>
>> Either way, the compiler produces the same code:
>>
>>  add r0, r0, #1
>>  bic r0, r0, #1
>>
>> I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".
>>
>> Might as well use the macro so it's clear. There is also round_up(x,y), which I believe is intended to be used
>> only with power of 2 values of y.
>
> I confirmed round_up() macro.
> This macro is optimized to power of 2 argument,
> and it matches to this case and clear.
>
> I will replace to round_up() macro.

Good!


-- 
With Best Regards,
Andy Shevchenko
