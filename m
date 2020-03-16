From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 5.5 01/41] spi: spi-omap2-mcspi: Handle DMA size
 restriction on AM65x
Date: Mon, 16 Mar 2020 11:50:57 +0000
Message-ID: <20200316115057.GB5010@sirena.org.uk>
References: <20200316023319.749-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316023319.749-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 10:32:39PM -0400, Sasha Levin wrote:
> From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
>=20
> [ Upstream commit e4e8276a4f652be2c7bb783a0155d4adb85f5d7d ]
>=20
> On AM654, McSPI can only support 4K - 1 bytes per transfer when DMA is
> enabled. Therefore populate master->max_transfer_size callback to
> inform client drivers of this restriction when DMA channels are
> available.

As ever this only provides information to other drivers which may be
buggy.

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vaCEACgkQJNaLcl1U
h9Dyuwf/fRi4iGdV1A9vW0+wTm8Pznka9n9+PoM5TuqyP0qrul8iIK7h/H6xS7bF
wRQVfQDzo/SfuONZlUUZOvtQXevqHPOtFl2x3Qe1sVnE39byJc6qu/EDsrNYVLgg
DLzo+493Fh+HQgfAb+b80kh9XbZ4rN0qSsyPpt7Ygqj8EpG/so3qCir1BtkKBYAx
nVN/HglbGLu0VosqwfRzpUSgPp0mQlVVhrBX3eyL62c3GQ3+R2Fk9namhq4GYNDv
rcKj4Fi/WhkKOIzmjwPtep6I4uY5ZnM6XVFxa1KuM2p7NVMWlvSZhdn2wvWR0kOr
+dB4D+JEBdndXoBkq3Ywisrppx4JNQ==
=73L/
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
