From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Thu, 14 Nov 2019 16:26:52 -0600
Message-ID: <20191114222652.GA7517@bogus>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112193653.GB13374@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 12, 2019 at 07:15:47PM +0000, Mark Brown wrote:
> > On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> > > On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > > > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> > 
> > > > > +      interrupts:
> > > > > +        items:
> > > > > +          - description: main interrupt (attention) line.
> > > > > +          - description: dedicated wakeup interrupt.
> > > > > +        minItems: 1 # The wakeup interrupt is optional.
> > 
> > > > > +      interrupt-names:
> > > > > +        items:
> > > > > +          - const: irq
> > > > > +          - const: wakeup
> > > > > +        minItems: 1
> > 
> > > > How will this interact with a SPI device that defines interrupts at the
> > > > device level, possibly more than one of them?  Especially if the device
> > > > has its own idea what the interrupts should be called.
> > 
> > > My understanding that individual drivers should be able to override
> > > whatever the default behavior core has configured, and the device can
> > > establish their own mapping. We have this in I2C and I believe this
> > > works well.
> > 
> > > Is the concern about the device tree scheme or SPI core handling?
> > 
> > Both really.
> 
> So as I mentioned, the driver is not forced to use the interrupt
> supplied by the SPI core, and the worst thing is that the core
> configures the main IRQ as wakeirq and driver would need to call
> dev_pm_clear_wake_irq() before switching to correct one. I expect there
> will be just a few drivers needing that and many more would benefit from
> the default behavior and not needing to repeat the same boilerplate
> code.
> 
> As far as scheme goes - I hope that Rob could confirm that we can
> override number of interrupts and names in consumers of the binding, as
> needed.

This won't work. A device schema doesn't override what's defined here, 
but just further constrains this schema.

You could define a "spi irq" schema which devices can include if they 
want to, but I don't think this pattern is that common to SPI devices. 
There's not any spec behind compared to say alert irq for SMBus. 

The 'wakeup' irq name is standardized (for DT), but that's not SPI 
specific. About all we could define there is 'wakeup-source' is boolean 
and if there is more than one interrupt, one should be named 'wakeup'.

Rob
