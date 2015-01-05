From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: dw-mid: fix number of CS lines
Date: Mon, 5 Jan 2015 20:33:35 +0000
Message-ID: <20150105203335.GQ2634@sirena.org.uk>
References: <1420213732-5141-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1420213732-5141-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NOl3kBTBh+CNLogO"
Cc: linux-spi@vger.kernel.org, stable@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420213732-5141-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NOl3kBTBh+CNLogO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2015 at 05:48:52PM +0200, Andy Shevchenko wrote:
> According to specification the SPI1 has 5 bits for chip selects. The curr=
ent
> code limits it to 4 bits. The patch fixes that constant.
>=20
> Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm not seeing this as an obvious candidate for stable, it seems more
like a new feature really in terms of impact, and that doesn't look like
the commit that's being fixed - it's the last one that refactored things
but that's not the same thing.

--NOl3kBTBh+CNLogO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvUeAAoJECTWi3JdVIfQxnsH/1nsfoEFvlLXI94xstgkj/7y
52/XKQb4MKB6s7tX9G4Hd4bjCnsUWlFCmHI842kd4KYY2GDHZy/LCya+KVc5Efn7
pQV6agvYwkoeaBW2R4bmCHDDYCa8MGKsYPWyHDoAQOxTiZChTC9YdBjsDbDy8krC
spYdSmrMy+5gTug9twzGey2S33XqLzNEi2XfRnCA+UTgN7adE3mO7LXQ5qo9nMAj
I5t7XqO414WKxDGk3IuWNyv4vPqE7TSfkpyOQ5QwxihIH1lv0JeFX+RrsclRln8O
sjyLZhwGU+NOwcZoh7FzyGbY+uw8/eKND+2SUYMO8mkbxFPAqIBGoZu452Uq2ig=
=sK81
-----END PGP SIGNATURE-----

--NOl3kBTBh+CNLogO--
