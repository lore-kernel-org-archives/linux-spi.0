From: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 13:50:44 +0100
Message-ID: <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com> <20200214121145.GF4827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200214121145.GF4827-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 14, 2020 at 1:11 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Fri, Feb 14, 2020 at 01:02:22PM +0100, Simon Goldschmidt wrote:
> > On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
> > > Add support for the Cadence QSPI controller. This controller is
> > > present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> > > This driver has been tested on the Intel LGM SoCs.
>
> > This is v9 and still, none of the altera maintainers are on CC?
> > How will it be ensured that this doesn't break altera if it is merged?
>
> Given that this is a new driver I'd be very surprised if it broke other
> users?  I can imagine it might not work for them and it would definitely
> be much better to get their review but it shouldn't be any worse than
> the current lack of support.

It is a new driver, but the hardware it supports is not currently unsupported.
Both Vadivel and Vignesh have stated that this driver merely moves the existing
generic spi driver to the spi-mem interface and should replace the existing
driver.

So please correct me if I'm wrong, but to me it seems like if this driver won't
work on altera, and after merging it the currently working driver will be
removed, altera will be broken.

Regards,
Simon
