From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] spi: dw: support 4-16 bits per word
Date: Thu, 6 Sep 2018 12:09:26 +0100
Message-ID: <20180906110926.GF5360@sirena.org.uk>
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
 <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
To: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 09:49:44PM +0200, Simon Goldschmidt wrote:
> The spi-dw driver currently only supports 8 or 16 bits per word.
>=20
> Since the hardware supports 4-16 bits per word, adapt the driver
> to also support this.

Please don't send new patches in reply to old patch serieses, it makes
it harder to follow what the current version of things is and makes it
much easier for the patches to get lost in the old threads.

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluRCuUACgkQJNaLcl1U
h9D85wf/YmKZ8aHJOxpyDfdQmNcesGTi5ybZSc9SQDIs6hfflIjwDVpkOXc90rsL
q8ONe+x8RYrzp7a4Zm/SqAh8MFTfs4xIY16gQ9++yjXh+asVMoY79qFF13NyB+o9
0xy70bExYIsy+xNMMN4WcQ4MrsfnwjExFXhrZwkMCQkR99FHZogsH0Hw92SxPJ9r
A+t114XnHyMHYPpDV3VDaersBJJ4BAykA9AiEe7VIlP2yKglAv5jTc8n863npp2f
pkd0RkEmCIuyDhghJ2QQAJQNbZkfRzEWt0K7HPV5quWrUyJcVOHPhv1ISE94e//z
az+o622DzjT0GLkwmLISIgm9UD9N9w==
=vayP
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
