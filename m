From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] spi: spidev: Add support for Dual/Quad SPI
 Transfers
Date: Thu, 27 Feb 2014 13:51:39 +0900
Message-ID: <20140227045139.GO9383@sirena.org.uk>
References: <1393324819-3810-1-git-send-email-geert@linux-m68k.org>
 <1393324819-3810-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZHzn+A9B7nBTGyj"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393324819-3810-2-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rZHzn+A9B7nBTGyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2014 at 11:40:17AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Add support for Dual/Quad SPI Transfers to the spidev API.
> As this uses SPI mode bits that don't fit in a single byte, two new
> ioctls (SPI_IOC_RD_MODE32 and SPI_IOC_WR_MODE32) are introduced.

Applied, thanks.

--rZHzn+A9B7nBTGyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsRYAAoJELSic+t+oim9BhoP+QFeX1y99Xch4cdfMNyekLJu
4+awJvLm/HN7mg3Ulqk6KvUmWpBKXiZKjvY27qSex5e2RWII+Re6Gbf9RurQ4Co+
VODVmmZ4Mohz7N834ff5J/sMAfijIDhr/JDtf0YgdKxmFBF/vAh1QNonJ5htaFMf
TIxzgfRHImiaAOM7hI7k2nycnEt26Eok1WCUMZ+Dmv9k7s/SpfB+vwo/erc2No9+
9m0tI6DP1s6Oc9C2Fe6653hw9SsYQO+2fDJ+1OcJSY4KM64PVKXSQpE+GHZHcRes
0Uhpg354xMzJQ1Aa8bwbaD/S6zEezR4Njs0YM9WqiaqR8ufadwdhB07rxxrXnvyJ
Nq78tq2inrOnQ9P8vLvPaLl47TFCJwedYpk4iGZ4uyxXnc2G5kmZ3nC5Yu17WTkQ
CoIMVAwC3hZ43ZFg6k5QhVGAg6gWGoyaY6KPcBXVBwb+Qclz//yFuGj1h2e0RlTq
+ZwJKUmmK+xzAqB/F0I6t1M+mPBk80oo652OXELaiFIsZl/g0EbGXHbhpMgMYEnO
ACNJbNWgbM2Uips0TwptUAVkihzDYrm54qJJaCCpAauzGEt3B8JtB/S9edOWqeXc
H2vsk9y8IJbd50N5H/1+xciv2Q0E3YcM54VZ9c2Ym0NZUXxv7QkhI98GgGQRbmT2
USfjRQiKEPGE8Jq2I3tJ
=1Ds5
-----END PGP SIGNATURE-----

--rZHzn+A9B7nBTGyj--
