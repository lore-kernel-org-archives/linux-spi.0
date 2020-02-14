From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 12:11:45 +0000
Message-ID: <20200214121145.GF4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
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
In-Reply-To: <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 01:02:22PM +0100, Simon Goldschmidt wrote:
> On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> > Add support for the Cadence QSPI controller. This controller is
> > present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> > This driver has been tested on the Intel LGM SoCs.

> This is v9 and still, none of the altera maintainers are on CC?
> How will it be ensured that this doesn't break altera if it is merged?

Given that this is a new driver I'd be very surprised if it broke other
users?  I can imagine it might not work for them and it would definitely
be much better to get their review but it shouldn't be any worse than
the current lack of support.

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GjoAACgkQJNaLcl1U
h9DFowf/dUPgpqg67TDIxYiZvaUkTs4lN9TTlwny0tuP3jzOHCtCJKrCCH+4T1M3
WMPmx9MBpmgvd6ELTmOVYJDIOzmXEDYvqadQWhIoRdVlBakgeF89sPjs2P0VWiJk
1QqNtnf9BJxhFAsGsSRh+pR1PtKG8POJ3TCjcexvAYV3byEeG6/+aTP3/Sb7s2s1
YfvHfS8PVQoXhMAddcqO1BF8WA69chxlJjheCHMYflTX/331JqhO0wRyZ82qIx0P
lPh1e6BCzlui3pydHcFJDBxyVxeNj7mEYG2QA59SQH1SbzmKnRx9gNFeywncgpHt
QeSbR4+jGK2zIzfI9cH6vFGu48znRw==
=RGMb
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
