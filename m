From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 2/6] dt-bindings: spi/core: add wakeup-source
 optional property
Date: Mon, 26 Jun 2017 09:40:16 -0700
Message-ID: <20170626164016.GA4965@dtor-ws>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498039313-24220-3-git-send-email-jeffy.chen@rock-chips.com>
 <20170626160011.qi3bliz5jt6d5wgb@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170626160011.qi3bliz5jt6d5wgb@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 26, 2017 at 11:00:11AM -0500, Rob Herring wrote:
> On Wed, Jun 21, 2017 at 06:01:49PM +0800, Jeffy Chen wrote:
> > Update document devicetree bindings to support "wakeup-source" property.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > ---
> > 
> > Changes in v3: None
> > 
> >  Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > index 1f6e86f..0fa1ccf 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > @@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
> >  		    Defaults to 1 if not present.
> >  - spi-rx-delay-us - Microsecond delay after a read transfer.
> >  - spi-tx-delay-us - Microsecond delay after a write transfer.
> > +- wakeup-source   - Device can be used as a wakeup source.
> 
> wakeup-source is valid for any device with an interrupts property 
> already, so I don't think this is necessary.

Do you mean it is not necessary on SPI level or not necessary at all? Or
you disagree with wording? Because we do need a way to say that on given
platform the device is supposed to be configured as a wakeup source.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
