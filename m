From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: atmel: Fix interrupt setup for PDC transfers
Date: Thu, 26 Feb 2015 11:34:38 +0900
Message-ID: <20150226023438.GF6236@finisterre.sirena.org.uk>
References: <1424791977-2178-1-git-send-email-torfl6749@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mew6/suNvUayQDfo"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424791977-2178-1-git-send-email-torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mew6/suNvUayQDfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 04:32:57PM +0100, Torsten Fleischer wrote:
> From: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Additionally to the current DMA transfer the PDC allows to set up a next =
DMA
> transfer. This is useful for larger SPI transfers.

Applied, thanks.

--mew6/suNvUayQDfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oY9AAoJECTWi3JdVIfQyDUH/i8Qyz41y0S6c/RoZyjgWEgY
tePLzFst1TF5Zo054cfOdlmLucgtG5eBlDkpuGdOXWswn66DX8ds/oDLc9Y4dsCp
A2pBjb3CQvCFRW2wb+KR2E0Bvr8a0fc0ycrNAJKWuAWay/S6IhlWPmz8B6qLwyCL
hUsF9l7IamCjTDweFxEXkM/UyXOPaRB5yWVhF4JBB/8ISjudfJoSbafZERrtjjyi
6tUPeIchqUulpL900zhSmWcMXgqZktQVbBMRqYRMIC7bSGII+KSFLtehC7ovsbfX
duHEbfCWBmtmgneQIU1U1NxYPH25C7Fc6tFZ4RkhlwIdxCUxUuWukLVTqVTykP0=
=Osce
-----END PGP SIGNATURE-----

--mew6/suNvUayQDfo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
