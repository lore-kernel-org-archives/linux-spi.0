From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/13] spi: atmel: use endian agnostic IO
Date: Sun, 22 Mar 2015 18:01:10 +0000
Message-ID: <20150322180110.GN6643@sirena.org.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426693992-31163-10-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 03:53:08PM +0000, Ben Dooks wrote:
> Use the endian agnositc IO functions instead of the __raw ones for when
> the driver is in use on big-endian systems.
>=20
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> --
> CC: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (supporter:ATMEL SPI DRIVER)
> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> (maintainer:SPI SUBSYSTEM)
> CC: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM)

Applied, thanks.  If you don't want things to go into the message then
they should be after --- not --.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwNlAAoJECTWi3JdVIfQG6MH/R2R+hSQ7KQgW5c+Khg/huRy
nzpjVf0UxdHd5H1d2PdHmWOx5Ps8QAAFfbiPnBGQzOu9bv7go6kRMsqSFPkANrhN
5+3eJsrVwWgg1YVwxTMydN4lEks5e1EpBIm7INqVpE8WMw+uWeb/0mZT8zfKhtMd
UTGmfzcZ1StpBVWIMCP+aF1/Q/T+sy7pAIGhNGYSqsm99MfQ1Ny+S7WAC3D4XB0n
rJHiPntYSkrp0KaCpnmgHFrwiV8V3NdzgWiqBZzQB0mLMReC1P0iEZcek8OIL5jW
IFpN1IKMFu5PWt2+QKdERZ6b3KE5tjXjU79Is/tayhtE6YG25mWibV2ABJeSvKI=
=wME2
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
