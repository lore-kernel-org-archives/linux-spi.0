From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: Add the DMA properties for the
 SPI dma mode
Date: Tue, 19 Feb 2019 12:37:06 +0800
Message-ID: <CAMz4ku+PqA95OJ6kVtYp=4dtD=Gi6cwGVN=0kikv2666c2ZFXw@mail.gmail.com>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
 <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 18 Feb 2019 at 22:02, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 1:37 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > From: Lanqing Liu <lanqing.liu@unisoc.com>
> >
> > Add the DMA properties for the SPI dma mode.
> >
> > Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Remove sprd,dma-slave-ids property.
> > ---
> >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > index bad211a..3c7eacc 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > @@ -14,6 +14,11 @@ Required properties:
> >         address on the SPI bus. Should be set to 1.
> >  - #size-cells: Should be set to 0.
> >
> > +Optional properties:
> > +dma-names: Should contain names of the SPI used DMA channel.
> > +dmas: Should contain DMA channels and DMA slave ids which the SPI used
> > +       sorted in the same order as the dma-names property.
>
> These need to define the order and names.

Sure.

>
> > +
> >  Example:
> >  spi0: spi@70a00000{
> >         compatible = "sprd,sc9860-spi";
> > @@ -21,6 +26,8 @@ spi0: spi@70a00000{
> >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >         clock-names = "spi", "source","enable";
> >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > +       dma-names = "rx_chn", "tx_chn";
>
> Everyone else uses "rx" and "tx". Do you really need something different?

Okay, will change to use  "rx" and "tx". I will send incremental patch
to fix ths issues you pointed out. Thanks.

-- 
Baolin Wang
Best Regards
