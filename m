From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: rspi: Remove obsolete rspi-rz
 platform_device_id entry
Date: Wed, 24 Jun 2015 12:23:54 +0100
Message-ID: <20150624112354.GH14071@sirena.org.uk>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWfttuYc6zDiWgzG=SoFWKw7Ghkx3pREmM1vQiANus_bg@mail.gmail.com>
 <CAMuHMdUS-4GjTu324g2qXBQnyeOmYBt7JLUo4AXjRjcZo6Bs2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eY62naQ+F4Ej99qO"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUS-4GjTu324g2qXBQnyeOmYBt7JLUo4AXjRjcZo6Bs2Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--eY62naQ+F4Ej99qO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2015 at 11:19:09AM +0200, Geert Uytterhoeven wrote:

> Unlike the sh_eth case, I don't get a warning if CONFIG_OF=3Dn, because
> rspi_rz_ops is const. Not even with a picky gcc 4.1.2.

OTOH what's 4.2 going to do, or clang... =20

> > Please drop this one, will fix.

> And unlike the sh_eth case, this cannot be fixed with one #ifdef without
> restructuring the whole driver.

> Hence inclined to withdraw my drop requst.
> Mark, what do you think? Is this patch OK as-is?

Given that it's only removing one line I'm not sure it's worth the
effort.

--eY62naQ+F4Ej99qO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVipNKAAoJECTWi3JdVIfQ+wUH/0JaXWpAice9Aor/29+bsjuk
Zwo8GiP2iuMVUF3Kp0yCFc2cmdnQyi86GIpsTp317JIFePXLhbWbuAhD7FICpQ69
EUWhDUJHfuY56s51QNYUM1FcNt4iTaG0YN2KQbwxShpyyhVfqbnwIe55d5+62I1p
OApE3+a0ZY8EerBhUs5UHYcemlBYl30pbU4g9riNSVDvCj9wXL+qhNddDuLAfWqu
j966MXRIimrCFggoXs9GBMg5cFj7e9goZG5TQS3MXQiNDn9vkdYdf6s5dIZvz44Z
zesvcSW3UXOpHG8e0VS/bgfNPWrMfac6RSwz1O+GRMzQ6qmNy7H8PGUnsEXQjxk=
=D6mr
-----END PGP SIGNATURE-----

--eY62naQ+F4Ej99qO--
