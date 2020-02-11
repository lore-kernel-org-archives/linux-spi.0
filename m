From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for
 imx8mm, imx8qxp
Date: Tue, 11 Feb 2020 12:05:01 -0600
Message-ID: <CAL_JsqLJweVLgYhoU-3cmg1aFwRNtAehx2-Euy-cwUsRy2jsgw@mail.gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-4-aford173@gmail.com>
 <20200206184030.GA11381@bogus> <CAHCN7x+uCwyJ60ZG_0m5SgNmqUAyEwxqXVTL7nQzJLXxXrh+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHCN7x+uCwyJ60ZG_0m5SgNmqUAyEwxqXVTL7nQzJLXxXrh+Tw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 11, 2020 at 4:49 AM Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Thu, Feb 6, 2020 at 2:46 PM Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >
> > On Sun, Feb 02, 2020 at 06:59:49AM -0600, Adam Ford wrote:
> > > Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings
> >
> > s/do/to/
>
> Oops.  Thanks for catching that.
>
> >
> > > document.
> > >
> > > Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > > V2: No change
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > index 2cd67eb727d4..7ac60d9fe357 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > @@ -2,6 +2,9 @@
> > >
> > >  Required properties:
> > >    - compatible : Should be "nxp,lx2160a-fspi"
> > > +                         "nxp,imx8qxp-fspi"
> > > +                         "nxp,imx8mm-fspi"
> >
> > All 3 are different and no compatibility?
>
> This was all based on a series from NXP's repo where they have some
> data tables all associated to the various compatible entries, and they
> created a place holder for quirks.  Based on an older NXP repo, it
> seems like there might be some quirks associated to the different
> families, but the newer repo where I got this patch series didn't
> implement them, however, it's possible the quirks may enhance
> functionality later. If that's true, I think this is the best solution
> for future enhancements without having to change the compatibility
> names down the road.  Maybe someone from NXP can comment?  I am just
> trying to help push things upstream so we can support QSPI flash.  I
> would prefer to keep them separate for now, because we might have
> these improvements later. However, I'll do what you request.  Do you
> want me to drop the additional compatible flags and just use the
> original, or create a new one that's a bit more generic?

Neither.

If you already know that they have differences, then as-is is fine.

If they are believed to be 'the same', then you do:

compatible = "nxp,imx8qxp-fspi", "nxp,imx8mm-fspi";

assuming i.MX8MM was the first version.

This allows a MX8QXP to work without OS changes if the driver already
supports the previous chip. And if any quirks are found, then the OS
can handle them without a DT change.

Rob
