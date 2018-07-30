From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI controller
Date: Tue, 31 Jul 2018 08:44:04 +0900
Message-ID: <004f01d4285f$336d43f0$9a47cbd0$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com> <20180730214705.GA25882@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <mark.rutland@arm.com>,
        =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?=
        <yamada.masahiro@socionext.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <linux-kernel@vger.kernel.org>,
        =?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?=
        <hayashi.kunihiko@socionext.com>
To: "'Rob Herring'" <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730214705.GA25882@rob-hp-laptop>
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Rob,

I see.
I will add "Acked-by" and "Reviewed-by" tag by Rob in next version.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, July 31, 2018 6:47 AM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI controller
> 
> On Thu, Jul 26, 2018 at 04:09:02PM +0900, Keiji Hayashibara wrote:
> > From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >
> > Add DT bindings for SPI controller implemented in UniPhier SoCs.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > ---
> >  .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
> 
> Please add acks/reviewed-bys when posting new versions.
> 
> Rob
