From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 14:16:45 +0000
Message-ID: <20200214141645.GM4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
 <20200214131518.GJ4827@sirena.org.uk>
 <CAAh8qswA0TLY73URB8eUYm+nFK9q08Ep4wamz3rAE_5g3fd51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf72Gf+bfLC8kxKs"
Cc: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAh8qswA0TLY73URB8eUYm+nFK9q08Ep4wamz3rAE_5g3fd51g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rf72Gf+bfLC8kxKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 02:49:48PM +0100, Simon Goldschmidt wrote:
> On Fri, Feb 14, 2020 at 2:15 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'm not seeing anything in the driver that removes whatever the current
> > support is?  Unless it's just adding a duplicate driver for the same
> > compatible strings which is obviously a bad idea but at least means that
> > unless people enable the driver there's no risk of it colliding with the
> > existing one.

> It does add a duplicate driver for the same compatible strings. The current
> working driver is in 'drivers/mtd/spi-nor/cadence-quadspi.c'.

> In fact, the compatible string "cdns,qspi-nor" copied from the old driver to
> this new driver is *only* used for altera. TI has its own compatible string,
> the new Intel platform adds its own as well.

Oh, that's not good - it's adding a completely new binding for the same
compatibles which isn't OK.  We can transition to a new driver using the
same binding but we should be keeping the old binding.  If we're moving
the binding document around and/or transitioning to YAML that needs to
be done explicitly rather than adding a new document for the same
compatible.

> As long as that one doesn't get removed, I have nothing against this driver
> here. I'm only concerned that this will get forgotten. And given that I added
> altera guys to the loop in one of the previous versions, I just was surprised
> they aren't on CC in this version.

Yes, like I say it'd be much better to get their review.

--rf72Gf+bfLC8kxKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Gq8wACgkQJNaLcl1U
h9DHoQf+LsSB3ZHCDD01+GU4dangDKO0Y7qLxBcScMbJ4+Xuws5182R7ns4mhTmt
wTsTbbf+Y3qfIXqReAzBxs5lRRxl46CdLexDJe/CRPKr+ADYByxAOhYcQ8jtPZzd
9QNw3ftS8JICO81XdPsIH9FdPHbMfj1/H+Js5GhfppYUbsvvrxUI1njQ06mF6sOw
oCymlCc+ruUgLSR0fA4FsBrLFmWMJTor8kudFBLupMeJs9F3dB2jgmQbkHmlfm1z
X/fJnZRpD7voBp4x2TFfm+lx/m6OBPTLuOCuu6CON9p3ahH4KoSB1YXLl8S/d1Ew
YV2Vi7U/k2epOpGy2yjWnN2je8whYA==
=ysJH
-----END PGP SIGNATURE-----

--rf72Gf+bfLC8kxKs--
