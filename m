From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI
 dma mode
Date: Tue, 22 Jan 2019 09:11:22 +0100
Message-ID: <CAMuHMdUGm+AzHsSgPf2Z0aPApzu5-gPuv1YfLU+RhXNb1DQ9yA@mail.gmail.com>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
 <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com> <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Baolin,

On Tue, Jan 22, 2019 at 3:23 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 21 Jan 2019 at 21:53, Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Jan 15, 2019 at 7:47 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> >
> > The email address should be updated with unisoc.com.
>
> Sure.
>
> >
> > > Add the DMA properties for the SPI dma mode.
> > >
> > > Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > index bad211a..01ef53f 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > @@ -14,6 +14,12 @@ Required properties:
> > >         address on the SPI bus. Should be set to 1.
> > >  - #size-cells: Should be set to 0.
> > >
> > > +Optional properties:
> > > +dma-names: Should contain names of the SPI used DMA channel.
> > > +dmas: Should contain DMA channels which the SPI used sorted in the
> > > +       same order as the dma-names property.
> > > +sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
> > > +
> > >  Example:
> > >  spi0: spi@70a00000{
> > >         compatible = "sprd,sc9860-spi";
> > > @@ -21,6 +27,9 @@ spi0: spi@70a00000{
> > >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > >         clock-names = "spi", "source","enable";
> > >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > > +       dma-names = "rx_chn", "tx_chn";
> > > +       dmas = <&apdma 11>, <&apdma 12>;
> > > +       sprd,dma-slave-ids = <11 12>;
> >
> > When would this be different values from what's in 'dmas'?
>
> Slave id is not always same with the DMA channel number in 'dmas', and
> it is just coincident for SPI driver. Moreover for different SoC , the
> slave ids for DMA engine consumers are not same. So we need one
> property to specify the slave id for the consumers to trigger DMA
> transfer.

Perhaps the DMA controller should use #dma-cells = <2>, so you can specify
the second value in the dmas property?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
