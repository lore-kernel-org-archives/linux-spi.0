From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: do not fail if the CS line is not connected
Date: Fri, 17 Jun 2016 11:47:25 +0100
Message-ID: <20160617104725.GC26099@sirena.org.uk>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466150245-2648-2-git-send-email-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 04:57:21PM +0900, Andi Shyti wrote:
> Some SPI connected devices do not have any CS line connected as
> some devices are alway enabled. Indeed, until now, a common
> workaround was to assign to num_chipselect a -1 value or 255
> (num_chipselect is unsigned).
>=20
> In this case do not fail and defer to the SPI device drivers the
> responsibility to check whether the num-cs is '0'.

A SPI controller always has one chip seelct, it may not be controllable
but it's at least logically present.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY9UIAAoJECTWi3JdVIfQ3BgH/2YUommqm4lK7fD/NVZqCS5T
rTdaBmZouhd44wxQzcS1SSfJLiQzFJjQDwDfaZThlUWTsz55x08QBrAHcwopXRiO
kkB45/z/1G3Y4EVJSl3WAD3a3CkaIfipneqUi4qjO7SOGA1W/A62JbpK5zBFUOvI
WDLXBfKMwWKYa8fDHT0CUuM13wxuptLjL2K1d38GWOWbtQEOGTkktg8VnFTzxyQj
kZdl0rxW8pUhc5HB4irAS/F+h76LrRzf8dRX8mIrXJKGciBtD4Uvm6rhLZ4S9Dva
JvahBV2D6dAilzbjuvP2M9D9VWkcvVJJgtBnljy/gFxftLMU4GhOoiWjVirNr2k=
=Ckc+
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
