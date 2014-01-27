From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/14] spi: rspi: Abstract transfer_one() for RSPI and
 QSPI
Date: Mon, 27 Jan 2014 20:03:22 +0000
Message-ID: <20140127200322.GG11841@sirena.org.uk>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
 <1390553044-11860-6-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q5Q2TEEGbX9oWZOX"
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390553044-11860-6-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Q5Q2TEEGbX9oWZOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 09:43:55AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Split off qspi_transfer_one() (which doesn't support DMA yet) from
> rspi_transfer_one().
> Replace the abstraction of send_pio()/receive_pio() by the abstracrion of
> transfer_one().

Applied, thanks.

--Q5Q2TEEGbX9oWZOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5ruHAAoJELSic+t+oim9OVwP/RUKKneqqsdAxda0ogJbni5a
opa1q2B7GCxPwv3Ld3zz+BbPId9QykreCp+prg2acAPnKly8syHHV1wLvuTkwaB/
YWwPq0plHlleCefhMLmCmXFJzJvnnkbMUpSnqWOhPyF6I5NTs1u59R5kWKU6tXwh
4OZsEoWQTjeK4MiwSJKG9I5X4QZ4rlAlchd+bA8DD1YvImsk5eV6A3c5UEwEce2c
hs5c6lGeUCU7R4hOG234g45Z0kjgKKBKOPlpj8qoxVzQyrlff6HuendWVGCp05zZ
a3j38yuKI3QWpoPPiQobyj8ULxNjBjOn+tb9/i+sWYD9KqCE5ODLzYhTJ45VLJUP
YYMkqLVwIleI16NdMSUO7Uy23o7qRdZqfwuU2gLondJDoZw+xlEbnZy0hx88cePD
Tm2JWaPTmhjkaxmnSyoOJKFwbWldG9mGbfspcC1SktlEXTs4E8Z2W+OBsqeme1t5
IbhvNPYxstUGXhKfoSS5HBsAF2YJMTh4PP62VEiX5tgiS9O6EGmXX2PvaM0QyZJH
bh8+vyZhMsmyyaqEt9nGq5SsecP2padwzxPkgUNu/J75OQsJl34kskJD3S630OyV
iqUExS2wM2HETFscwzRqxpPBrFRg48jg4+NyT+sscSS570lxwv7mfISWR7Iypz/z
36wB+4uSGtw8gPjjSTsr
=8kJe
-----END PGP SIGNATURE-----

--Q5Q2TEEGbX9oWZOX--
