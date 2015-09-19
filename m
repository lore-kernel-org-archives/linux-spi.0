From: Mark Brown <broonie@kernel.org>
Subject: Re: spi-imx: wait_for_completion should timeout even in non-DMA
 transfer cases
Date: Sat, 19 Sep 2015 10:56:14 -0700
Message-ID: <20150919175614.GM30445@sirena.org.uk>
References: <CAH-u=81E2RnMvm2UZxUasCSf6hMQtiMO9Y1VcNiy0pFR6Uy6vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TxukmIqg3MmZ0Kmh"
Cc: linux-spi@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH-u=81E2RnMvm2UZxUasCSf6hMQtiMO9Y1VcNiy0pFR6Uy6vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TxukmIqg3MmZ0Kmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 02:38:27PM +0200, Jean-Michel Hautbois wrote:
> Hi,
>=20
> I am wondering why in spi-imx the spi_imx_pio_transfer() function is
> calling wait_for_completion() and not wait_for_completion_timeout() as
> in the spi_imx_dma_transfer() one.
> I can't see a good reason for this, maybe should it be calculated
> based on the spi clock and transfer->len, or at least be the same as
> IMX_DMA_TIMEOUT which is 3 seconds ?
> If you want it, I have a patch, just tell me if you are interested and
> if you prefer a calculated timeout or even something else ?

A calculated timeout is probably best.

--TxukmIqg3MmZ0Kmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/aG+AAoJECTWi3JdVIfQd4oH/0RnrjDp8viTo7YCTvao6Eub
fHylLNUfBFYTZA5NToaeEoLqFGle1IvT7fB/EL5B7jHOgkzRWo7oR+6XUlFSA7pv
r4a5tkcW4o2jrxJgFJw7vBgYQ8Qb3BV1RHwNoevi8fJBhNGh0Va+xI4F8RakkXSm
sZPepyI57D/NrSTSN8JRZsHHfaD8VD01QrA/DYSedCFOUybFo3sKTBDz5LArhQ1i
KsFd8BMKkCw/FewqiQMm8i14kO7PT/gkv0o5AI3q/+IJ/mjy64eUBQh4jKFfxdD7
aC01N1Npj58zEsFe5gttmpddkSUPVPMF5qO0JVz6oOthJe3NgMniD09O2hEPfDY=
=gNni
-----END PGP SIGNATURE-----

--TxukmIqg3MmZ0Kmh--
