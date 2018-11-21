From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
Date: Wed, 21 Nov 2018 22:21:57 +0100
Message-ID: <20181121212157.GD12656@piout.net>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
 <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
 <20181121164820.GC12656@piout.net>
 <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: radu_nicolae.pirea@upb.ro,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.co>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21/11/2018 14:52:29-0600, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 10:48 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > > > +Optional properties in serial and SPI mode:
> > > > +- dma bindings for dma transfer:
> > > > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > > > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > > > +               Refer to dma.txt and atmel-dma.txt for details.
> > > > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> > >
> > > > +               dma-names = "tx", "rx";
> > >
> > > The dma-names should have a defined order.
> > >
> >
> > Why is that? Isn't the purpose of names to get rid of any particular
> > ordering?
> 
> Because a fundamental rule of DT is the order is defined and
> important. The purpose was to allow for cases that had a variable
> number of entries, but even a variable number still have a defined
> order.
> 

Thank you for the clarification!


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
