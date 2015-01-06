From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: drop redundant sirf,marco-spi compatible
 string
Date: Tue, 6 Jan 2015 17:39:07 +0000
Message-ID: <20150106173907.GJ2634@sirena.org.uk>
References: <1420275884-10942-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TWU5dZlpCh7alCLz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420275884-10942-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TWU5dZlpCh7alCLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2015 at 05:04:44PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>=20
> "sirf,marco-spi" is redundant as all SPI controllers in CSR SiRFSoC are
> compatible with prima2-spi.
> at the same time, the whole marco project was dropped and its replacement
> atlas7 is also compatible with prima2 in SPI.

Applied, thanks.

--TWU5dZlpCh7alCLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrB27AAoJECTWi3JdVIfQdB4H/3XED/w0YM/BMUX9tt8Sy3D+
As0WqwgluvFwrWv+3qh9ylvj8Bxk4Q20ytmtQHIcN4lO+L4mLW8egzmRcmEx7Rph
Y1y+gvi6OQRsdkZCnywMCUrj90mOfNVZ705QtIPlVf7bxNam4qA37IL+o9aKvxfj
LO6XcggVP09IApR7fnSp2EdcmRwBzj8Q1nldB5Kp3xdCqbkpwwY94DF9QcjnCf3a
pklDRowNecIRL6r+bjbzI3Gm1xKH06iKOOGIjRTIJhYKbJy2t18iVwp0hKQOhzK5
OX8xX4SRYUIBqFb/dTUV8dzDIhzKfr1qMetXpjLxAMmAx/iCKQn1kK7DrliBmSA=
=SsPg
-----END PGP SIGNATURE-----

--TWU5dZlpCh7alCLz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
