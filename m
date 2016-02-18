From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Use %u for unsigned int, %zu for size_t
Date: Thu, 18 Feb 2016 13:36:19 +0000
Message-ID: <20160218133619.GB7129@sirena.org.uk>
References: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 02:32:57PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> When printing unsigned int it is more idiomatic to use %u, for size_t
> the correct specifier is %zu (see Documentation/printk-formats.txt).

These don't apply against current code, please check and resend.  Fabio
sent some similar patches the other day.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxcjSAAoJECTWi3JdVIfQLvYH/RukoNTktLwHURPkwymPvRWm
knELojEE8B+BcGZc8Se+yCLRwXwMxFTvrcuWI8EMlWEhO2P/LdhvWdtxMv3dkrAm
bQZGuM2vUQ0ocj2CafkGeAfwFD6gdnFIuuQK402uhtK4TD5gwV9KyLmy9Pae+SdI
n+bL5zDnHaDORgpCMw5hLFo6lVVqT1+1/DIjKIB1RWw9Z0remSytdq1iv66Ya5nv
7yl1ymL9FPv2VoCrY3BOvqwG7vwn2gMUxGjKH0B/zd2HBw/WbXuJgvUGgAmj8NQ9
N8sTTLLRGxmXFa0Ys2jFoJnC38A9NXiM+MEUzkyDNX6vGSygCJyqPniff8P6vbg=
=6a+7
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
