From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Date: Fri, 7 Jul 2017 09:17:44 -0500
Message-ID: <20170707141744.atno6j3f7hcidxze@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-11-hauke@hauke-m.de>
 <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "martin.blumenstingl" <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        john <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "hauke.mehrtens" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 03, 2017 at 10:51:51AM +0300, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> > From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> >
> > The reset controllers (on xRX200 and newer SoCs have two of them) are
> > provided by the RCU module. This was initially implemented as a simple
> > reset controller. However, the RCU module provides more functionality
> > (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> > The old reset controller driver implementation from
> > arch/mips/lantiq/xway/reset.c did not honor this fact.
> >
> > For some devices the request and the status bits are different.
> 
> > +Required properties:
> > +- compatible           : Should be one of
> > +                               "lantiq,danube-reset"
> > +                               "lantiq,xrx200-reset"
> > +- offset-set           : Offset of the reset set register
> > +- offset-status                : Offset of the reset status register
> 
> Just one side comment (I'm fine with either choice, just for your
> information). Recently I have reviewed at24 patch which adds a
> property for getting MAC offset and my reseach ends up with the naming
> pattern mac-offset (as many others are doing this way). So, perhaps in
> your case it might make sense to do that way? Anyway, it's a matter of
> a (bit of a) chaos in DT bindings, whatever you decide users will live
> with.

Not a pattern I want to standardize. Describing offsets is generally an 
indication of the compatible not being specific enough.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
