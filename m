From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date: Thu, 26 Jul 2018 16:44:08 +0300
Message-ID: <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com> <001b01d424c4$66e04230$34a0c690$@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?=
        <yamada.masahiro@socionext.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?=
        <hayashi.kunihiko@socionext.com>
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001b01d424c4$66e04230$34a0c690$@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 26, 2018 at 12:38 PM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:

>> > +       /* check if requested speed is too small */
>> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
>>
>> > +               return -EINVAL;
>>
>> So, does this critical?
>
> If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> I don't change it to high frequency, and it is daringly an error.
> On the other hand, when changing to low frequency, I will change it automatically.

No. My point is, if somehow user asks for that condition to be
happened you bail out, while when using clamp_val() you may continue
to work at maximum limit, though issue warning to user, for example.

>> > +
>> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
>> > +               ckrat = SSI_MIN_CLK_DIVIDER;
>>
>> clamp_val()  / max() ?
>
> I will modify it to use max().

See above.

-- 
With Best Regards,
Andy Shevchenko
