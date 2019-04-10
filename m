From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 11:32:50 +0100
Message-ID: <20190410103250.GF6106@sirena.org.uk>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:22:44PM +0200, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of the transfer mode used (DMA or GPIO).
>=20
> This info is useful to individuate the timing when
> the module starts.

Adding this sort of message to every driver is going to make boot far
too noisy, it's one thing if we actually enumerate information about the
physical device but this isn't really that.  There are already prints in
the driver core for when things get probed which can be enabled if
ordering issues need to be debugged.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytxlEACgkQJNaLcl1U
h9AZ7Af+OiGmnQX7HRlnqJrTrMzmIi+/NnGXg5Wo0T0IE1uEoQ1jTgHEgpBZX8A3
jandhhRDVzZiXSgnnLavco55WLdNuU9aoaX/vZrOuWyUv7SRgiZQ1NSM7HtMM7pE
3b0acqhQwGdThQ6RICWb7fkna6u6ylLTr6CUKQ7FHuu/pcUwA2FIaZBDSHYFQeBO
o5sHOgp07QOaQG09TSM9G/7YzTuKbUjAq4d7+iytKxxtgu5ZlLppMqGAYt9PZD0r
8fRKtGdWaxpdf/ww3P1Nj8d84hnicLoawTlGRFJsi6fX2y7u6M6tcS8gyx0TIweP
U+MoafBik8icmF32XQwsRNlE7yZC4g==
=xpxE
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
