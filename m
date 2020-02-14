From: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 14:49:48 +0100
Message-ID: <CAAh8qswA0TLY73URB8eUYm+nFK9q08Ep4wamz3rAE_5g3fd51g@mail.gmail.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk> <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
 <20200214131518.GJ4827@sirena.org.uk>
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
In-Reply-To: <20200214131518.GJ4827-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 14, 2020 at 2:15 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Fri, Feb 14, 2020 at 01:50:44PM +0100, Simon Goldschmidt wrote:
>
> > So please correct me if I'm wrong, but to me it seems like if this driver won't
> > work on altera, and after merging it the currently working driver will be
> > removed, altera will be broken.
>
> I'm not seeing anything in the driver that removes whatever the current
> support is?  Unless it's just adding a duplicate driver for the same
> compatible strings which is obviously a bad idea but at least means that
> unless people enable the driver there's no risk of it colliding with the
> existing one.

It does add a duplicate driver for the same compatible strings. The current
working driver is in 'drivers/mtd/spi-nor/cadence-quadspi.c'.

In fact, the compatible string "cdns,qspi-nor" copied from the old driver to
this new driver is *only* used for altera. TI has its own compatible string,
the new Intel platform adds its own as well.

As long as that one doesn't get removed, I have nothing against this driver
here. I'm only concerned that this will get forgotten. And given that I added
altera guys to the loop in one of the previous versions, I just was surprised
they aren't on CC in this version.

I'm not familiar with whom to CC for Linux drivers, so sorry for the noise
if I'm overreacting here, just tell me.

Regards,
Simon
