From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
Subject: RE: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date: Mon, 30 Jul 2018 10:46:05 +0900
Message-ID: <002101d427a7$14516f90$3cf44eb0$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com> <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com> <001b01d424c4$66e04230$34a0c690$@socionext.com> <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Mark Brown" <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?=
        <yamada.masahiro@socionext.com>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?=
        <hayashi.kunihiko@socionext.com>
To: "'Andy Shevchenko'" <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Andy,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andy
> Shevchenko
> Sent: Thursday, July 26, 2018 10:44 PM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>; linux-spi <linux-spi@vger.kernel.org>; linux-arm
> Mailing List <linux-arm-kernel@lists.infradead.org>; devicetree <devicetree@vger.kernel.org>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Hayashi, Kunihiko/林 邦彦 <hayashi.kunihiko@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, Jul 26, 2018 at 12:38 PM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> 
> >> > +       /* check if requested speed is too small */
> >> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
> >>
> >> > +               return -EINVAL;
> >>
> >> So, does this critical?
> >
> > If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> > I don't change it to high frequency, and it is daringly an error.
> > On the other hand, when changing to low frequency, I will change it automatically.
> 
> No. My point is, if somehow user asks for that condition to be happened you bail out, while when using clamp_val()
> you may continue to work at maximum limit, though issue warning to user, for example.

Thank you. I understood what you pointed out. 
However, I found this code unnecessary as pointed out by Radu, 
so I will delete it.

> >> > +
> >> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> >> > +               ckrat = SSI_MIN_CLK_DIVIDER;
> >>
> >> clamp_val()  / max() ?
> >
> > I will modify it to use max().
> 
> See above.

This is also the same as above.

> --
> With Best Regards,
> Andy Shevchenko

-----------------
Best Regards,
Keiji Hayashibara
