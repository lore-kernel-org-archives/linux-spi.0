From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
Date: Wed, 26 Sep 2018 17:37:10 +0200
Message-ID: <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
References: <20180918093437.26799-1-lukma@denx.de> <20180918093437.26799-2-lukma@denx.de>
 <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com> <20180926163212.17646e43@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: lukma@denx.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926163212.17646e43@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lukasz,

On Wed, Sep 26, 2018 at 4:33 PM Lukasz Majewski <lukma@denx.de> wrote:
> > On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote:
> > > This commit provides the description of new property:
> > > "fsl,spi-slave-mode" which enables support for DSPI driver working
> > > in slave mode.
> > >
> > > As the new compatible shall be used with SPI bus equipped with
> > > master device a new "spidev" based node has been introduced to
> > > avoid confusion.
> > >
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > > 18eeafe359d8..b30af19a2bc5 100644 ---
> > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@ -26,6
> > > +26,7 @@ Optional SPI properties for slave nodes:
> > >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > > the clock signal and deactivating chip select, at the end of a
> > > transfer.
> > >  - bus-num : the slave chip chipselect signal number.
> > > +- fsl,spi-slave-mode: if present, controller runs in slave mode.
> >
> > There's a standard property for this.
>
> I've just realised that there is "spi-slave" property in the
> Documentation/devicetree/bindings/spi/spi-bus.txt
>
> I will convert the code to use it.
>
> >
> > >
> > >  Example:
> > >
> > > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> > >             fsl,spi-cs-sck-delay = <100>;
> > >             fsl,spi-sck-cs-delay = <50>;
> > >     };
> > > +
> > > +   spidev3@1 {
> > > +           compatible = "fsl,vf610-dspi";
> > > +           spi-max-frequency = <30000000>;
> > > +           reg = <1>;
> > > +           fsl,spi-slave-mode;
> >
> > This doesn't look right for how slave mode is described.
>
> You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?
>
> Or is there any other issue with this code?

According to Documentation/devicetree/bindings/spi/spi-bus.txt:
  1. "spi-slave" should be a property of the controller node, not of the
     slave node,
  2. the slave node should be called "slave", without unit address, and
     without "reg" property.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
