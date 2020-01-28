From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
Date: Tue, 28 Jan 2020 12:05:30 +0000
Message-ID: <20200128120530.GC4689@sirena.org.uk>
References: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
 <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2020 at 10:20:24AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 28, 2020 at 8:26 AM Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org> wrote:

> > eSPI controller can't send transactions without hardware chip selects.
> > So, to use GPIO chip selects with eSPI controller we need to use one
> > dedicated hardware chip select signal. To specify shared chip select for
> > GPIO use "fsl,espi-shared-chipselect" DT property.

> Do you need a property to specify this?
> Can't the driver just pick an unused native chip select instead?
> Recently I've added generic support for that to the SPI core, cfr. commit
> 7d93aecdb58d47e8 ("spi: Add generic support for unused native cs with
> cs-gpios").

The only reason I would expect for needing this is if there's no pinmux
control so you need to make sure that the chip select used isn't going
to cause electrical problems.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4wI4kACgkQJNaLcl1U
h9ADRAf/Y03I7ojskz2VRSttCwF5mPVZ8f9FuZbuns0qAlsZfboYpHBgTd62JX1Y
CVjMxdh4nYxsfK3jWX1bOjXUI0n/czEGmFDL7TDa83yVs0lDEzsHIzVG/HXVHlw/
5fcf6AChhdSWGiM9MCcoZucRGxx/iDGA6bejPGnWMO6/zHPtsiFuANP9cLneB7HV
J9RWGKOIVXUU/VD1lV81Yjq65r3XctbFSah/Ga91ZfUThq6RO13JB7ZwwugrtOeQ
un3kU7XPFW5cKkAiAT7syIEvP8nelDuXF2hZuEVoVfg6YZp3Z3puyNjcNCXiZ/el
uj4ZW9+0rY199hakdsKxYAFnvwJIWA==
=FRSf
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
