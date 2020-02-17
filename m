From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Mon, 17 Feb 2020 11:52:13 +0000
Message-ID: <20200217115213.GA9304@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4712cdc4-34cd-990b-3d53-3d394ae1250b-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 05:28:38PM +0800, Ramuthevar, Vadivel MuruganX wrot=
e:
> On 14/2/2020 8:11 PM, Mark Brown wrote:

> > Given that this is a new driver I'd be very surprised if it broke other
> > users?  I can imagine it might not work for them and it would definitely
> > be much better to get their review but it shouldn't be any worse than
> > the current lack of support.

> *[Vignesh]*=A0 The legacy driver under drivers/mtd/spi-nor will be remove=
d as
> we cannot
> support both SPI NOR and SPI NAND with single driver if its under
> spi-nor. New driver should be functionally equivalent to existing one.
> So I suggest you test this driver on legcay SoCFPGA products.

You're not actually removing the driver here, you're adding another
driver for the same thing.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KfmwACgkQJNaLcl1U
h9DBWAf+OHZ1rJV0+WA7kk3V0MqnCBMFLhoDTTlX4vp37gCaeNjn4YryKDsoh0qG
uoW93R7bcLcYmXsJ9SWxOWU68D2ekuSx0/AGRk9kMfDEmfQUQvjP9pTF+4wASigO
7vi7ml0sLaRBEWViXX0oOpI6RaDBmU7VO/au9QZogPHKPtCqkw+yAc1v0tszou65
bkg7faKKy6UCEUK2cgPxMkcLGKaN69B4Ov+AQX3uPubbQ5GhpmZ2f8lB2NbTHohX
etPjO6YF/D/k/r9OT+eFfAA8WUseco1PQX4ol46IrkxFMA3ak7FTDb07JFt4BB+s
lpLjrWId2xE+4PaCIvCTJIhEhEcNOA==
=fH+E
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
