From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA
Date: Sun, 14 May 2017 18:50:20 +0900
Message-ID: <20170514095020.roqoeohylvrgoad7@sirena.org.uk>
References: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ptb4pqnxpa66vw3k"
Cc: Vignesh R <vigneshr@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ptb4pqnxpa66vw3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:37:18AM +0200, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
>     ERROR: "bad_dma_ops" [drivers/spi/spi-ti-qspi.ko] undefined!
>=20
> Add a dependency on HAS_DMA to fix this.

There's no progress on fixing the architectures that don't do DMA to
stub it out?  :(

--ptb4pqnxpa66vw3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYKFsACgkQJNaLcl1U
h9CV6gf9F7uo1sLmeJ2XD4nl6c3DSHPZ0Ru4mzUU/X/KBhsSxpawH+HD8S9DtIWA
g6tpK3m7ERfa590AUHq1NDZo5QR6IlW+pzblX499Kj+WFabZ3F0m867xeQMnf9iO
y/PuR13XNoUFZgwCfITKLBYnhv5Z8giysBVzTJEAXKOzFGtWJ39RXWDt5usbCC7H
gPNMShrXgxz//Vqc97BYxaNEarIkT7Aea+22VUEBgY7ZdYaZ49VJdyy6QLy6cF2e
HgYeVXfXhGuwZ7nKwUPzUml3fln2cRIjClpAvRVtAPN3dEOflTGrwHgpaaS0NGsk
WzOKHz9KHDbDUFVlEZP0+c5DSYXMRg==
=Pesp
-----END PGP SIGNATURE-----

--ptb4pqnxpa66vw3k--
