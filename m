From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Tue, 12 Nov 2019 11:03:28 -0800
Message-ID: <20191112190328.GA199853@dtor-ws>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112120307.GB5195@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> 
> > +      interrupts:
> > +        items:
> > +          - description: main interrupt (attention) line.
> > +          - description: dedicated wakeup interrupt.
> > +        minItems: 1 # The wakeup interrupt is optional.
> > +        description:
> > +          Specifies interrupt lines a device is connected to. Typically a
> > +          device is wired to a single interrupt line that is used as
> > +          "attention" signal and also to wake up system when device is
> > +          set up as wakeup source. However on some systems a dedicated
> > +          wakeup line might be used.
> 
> > +      interrupt-names:
> > +        items:
> > +          - const: irq
> > +          - const: wakeup
> > +        minItems: 1
> 
> How will this interact with a SPI device that defines interrupts at the
> device level, possibly more than one of them?  Especially if the device
> has its own idea what the interrupts should be called.

My understanding that individual drivers should be able to override
whatever the default behavior core has configured, and the device can
establish their own mapping. We have this in I2C and I believe this
works well.

Is the concern about the device tree scheme or SPI core handling?

Thanks.

-- 
Dmitry
