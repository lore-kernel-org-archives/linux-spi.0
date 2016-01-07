From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
Date: Thu, 7 Jan 2016 15:40:24 +0000
Message-ID: <20160107154024.GF6588@sirena.org.uk>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
 <yw1xvb771yrl.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kb0TSCuX821Ar6UT"
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xvb771yrl.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kb0TSCuX821Ar6UT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 09:50:54PM +0000, M=E5ns Rullg=E5rd wrote:
> Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:

> > +	as->use_cs_gpios =3D true;
> > +	if (atmel_spi_is_v2(as) &&
> > +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> > +		as->use_cs_gpios =3D false;
> > +		master->num_chipselect =3D 4;
> > +	}

> This part breaks the AVR32 boards and probably anything else that
> doesn't use devicetree but does use GPIOs for chip select.

Shouldn't this just be setting defaults for the case where nothing is
provided?

--kb0TSCuX821Ar6UT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjobnAAoJECTWi3JdVIfQcOIH/0IRDnR/cOnV4JzxMw20Yvll
YSsZtp3wzhw4N2iP8QBqXmh2v1nPCEOt86G209PUhHd0o0akfLC1Rd/FoO7YL2oj
gQg5nATqrbrW1yx2TQBkMD+FrYr8cGA7Pf402fPK1uSwEmhmnEqoUdx0mbq8a2Go
htOtk/npZ/rPGxoeiIpSsg47hipzC4Ny2BkoEYScIjeKGnTPWY1LYGD8E07/+M+Z
SNKUv7n50cAZ8qIo5+tDamT8yycfHTRdwdjDDDB24uagx0j7VtQxOsqoUDqsGPGZ
9+/2S1TFvEVR13qHo0UUL6mtiiGQbcI2eFsHoxAKp3JmdQxPwqWjbRCc8Ludma4=
=caE8
-----END PGP SIGNATURE-----

--kb0TSCuX821Ar6UT--
