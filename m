From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Date: Mon, 4 Sep 2017 13:36:43 +0100
Message-ID: <20170904133643.00004c84@huawei.com>
References: <cover.1503407738.git.lukas@wunner.de>
        <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
        <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
        <20170827153405.GA13399@wunner.de>
        <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
        <20170903143429.749be480@archlinux>
        <20170903182046.GA1511@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Adriana Reus <adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>,
        "Lars-Peter Clausen" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>,
        Oskar Andero <oskar.andero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andrea Galbusera <gizero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Manfred Schlaegl <manfred.schlaegl-RbZlAiThDcE@public.gmane.org>,
        Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>,
        "Soeren Andersen" <san-KGKi0rHxN0fKWSuBa/xFvVpr/1R2p/CL@public.gmane.org>,
        <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "Abhisit Sangjan" <s.abhisit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170903182046.GA1511-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 3 Sep 2017 20:20:46 +0200
Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:

> On Sun, Sep 03, 2017 at 02:37:49PM +0100, Jonathan Cameron wrote:
> > On Tue, Aug 22, 2017 at 03:33:00PM +0200, Lukas Wunner wrote:    
> > > --- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > > +Optional properties:
> > > +   - microchip,continuous-conversion (boolean):
> > > +           Only applicable to MCP3550/1/3:  These ADCs have long
> > > +           conversion times and therefore support "continuous
> > > +           conversion mode" to allow retrieval of conversions
> > > +           at any time without observing a delay.  The mode is
> > > +           enabled by permanently driving CS low, e.g. by wiring
> > > +           it to ground.    
> > 
> > hmm.  This is odd.  We probably need to make the SPI subsystem aware
> > of this. It is possible to ask for exclusive use of an SPI bus and
> > I think we should be doing this here.  It may be wired low on your
> > board, but it may be wired to a controllable chip select on other
> > boards and we can still force it low to trigger this mode if it makes
> > sense for the current application.
> > 
> > So I'd argue what we actually need to represent here is that the CS line
> > is not controllable.  What this means to the driver should be handled
> > in the driver - ideally also dealing with the case where it is controllable
> > appropriately (via exclusive bus usage).  Spi devices have the SPI_NO_CS
> > bit in the mode member of the spi device but I'm not sure about bindings.  
> [...]
> > The one case where we normally want to flip to continuous modes is when
> > we have a chardev access going on to the device.  In IIO that reflects
> > the fact we are in a push mode rather than userspace polling for new data.  
> 
> It seems there is no DT binding so far to set SPI_NO_CS.

Time to add one perhaps ;)

> 
> Conceivably, continuous mode could be used even with multiple devices
> on the bus if CLK and MISO is AND-gated with the CS signal coming from
> the SPI master.  (And the CS of the ADC is pulled low.)  In that case,
> the notion that "continuous mode == CS not controllable" would be
> incorrect, hence the approach I've chosen.
> 
> On the Revolution Pi we don't use continuous mode.  I merely included
> it in the driver for completeness.  If it is too controversial I'd be
> inclined to drop the feature.
> 
> On-demand switching to continuous mode by keeping CS low would be
> possible by setting the cs_change bit of struct mcp320x ->transfer[1],
> but that might not work if there are other devices on the bus.
> 

spi has exclusive bus access functions.  Doing this sort of thing isn't
that unusual.  Some devices require that the cs is held low whilst they
take a single reading, but provide an interrupt for when they are done.
For those we have to hold it for some time.

> 
> > Personally I don't think we are in a position yet to make this a generic
> > property - this is the first device where it is actually to do with the
> > physical circuit (and arguably it isn't really - see above).  
> 
> Okay.
> 
> 
> > Reference voltages are an oddity as the supply naming typically should match
> > that on the datasheet. It's 'fairly' consistent but some devices
> > have a set of relatively obscure references to different parts of the
> > input circuitry.  We can document it as a 'default' assuming nothing
> > strange is going on though.  This is why we have the vagueness below
> > on VDD and VCC.  
> 
> That is new to me, I believe it's not documented or am I missing something?
> I'd be happy to respin the below patch without the "Continuous mode"
> portion if you want?  (Amended with the info you gave above.)

It might make sense to drop continuous mode with the intent to add it
as a follow up patch.  Lets see what Mark and co come back with on how
to support the hard wired cs on the spi.

> Do you think iio-bindings.txt is the right place to put this or would
> a separate common.txt be more appropriate? (See e.g. leds/common.txt)

Perhaps a question best directed to the devicetree binding maintainers.
I can't say that I personally care either way ;)

> 
> Thanks,
> 
> Lukas
> 
> > -- >8 --    
> > Subject: [PATCH] dt-bindings: iio: Document common properties
> >
> > It's about time we standardize on common names for frequently used IIO
> > properties.  For starters, document "vref-supply" and "continuous".
> >
> > Suggested-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/iio/iio-bindings.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > index 68d6f8c..c3e87e15 100644
> > --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -95,3 +95,18 @@ vdd channel is connected to output 0 of the &ref device.
> >                 io-channels = <&adc 10>, <&adc 11>;
> >                 io-channel-names = "adc1", "adc2";
> >         };
> > +
> > +==Common IIO properties==
> > +
> > +Reference voltage:
> > +ADCs, DACs and several other IIO devices require a reference voltage.
> > +By convention the property specifying this regulator is named "vref-supply".
> > +If the chip lacks a dedicated Vref pin and instead uses its own power supply
> > +as reference, the property specifying the regulator is commonly named
> > +"vdd-supply" or "vcc-supply".
> > +
> > +Continuous mode:
> > +Some sensors can be configured to perform continuous (versus one-shot)
> > +measurements.  Continuous mode may require more energy in return for faster
> > +or more reliable measurements.  A boolean property named "continuous"
> > +signifies that the device is configured for this mode.
> > --
> > 2.11.0    
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
