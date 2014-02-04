From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/11] ARM: shmobile: RSPI RZ and QSPI SoC and board
 integration
Date: Tue, 4 Feb 2014 17:37:33 +0000
Message-ID: <20140204173733.GI22609@sirena.org.uk>
References: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgjcSYp0bZmR6cI7"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391527445-14881-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xgjcSYp0bZmR6cI7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 04:23:54PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
>=20
> This patch series contains SoC and board integration for
>   1. RSPI in the r7s72100 aka RZ/A1H SoC on the Genmai reference board,
>   2. QSPI in the r8a7791 aka R-Car M2 SoC on the Koelsch reference board.
> It was rebased on top of renesas-devel-v3.14-rc1-20140204.

Can you please stop CCing arch/arm only patch serieses like this to the
SPI list - they just mean I have to go through patchwork and mark them
as not applicable.

--xgjcSYp0bZmR6cI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8SVaAAoJELSic+t+oim9dtEP/2/JmuBcFthd862KIXt2EU7R
cLvKHGcxhuKBKXksQWBAYPAQ2S6oUqoIqnfTEO+9ffFT7ZU+MlqDxxcrpZEgS7IE
w3ZFlwt7FoEK0GR2iFAp9FoGKq0rFqcv2e6sO5dOT2CVLUCWIuCXLZeJs5fjmaJQ
LmFsJt3L3kvUaKtFdqmhd9SBakg9bAUhrq8L+LgvLUfO4A/g6P8NXlFzWJp23G51
koeV7sqQmX2Tp2BgwJl78CGBiPArxB8A3vURSktqwewsP7xEcSP+DfeqJ3SF0YOI
kI9i4L8oLyFgOISmf7ZpM554VAZgs68UNdkZ3Zv67rZ80xkCZ6zIBUtfVh5TFt/D
Nc2vNEzCFMJkbU64iLah4eL6jUmBb7LZECL96k4ey5FSqBikSe8AXVeSkV6kR+sd
BUYw3Y4xTYkvPMTKo7fSm6qTfs/AJM/R8/RBXjSmPCcVuHT2bT44jCFMSimGy6wM
Dv0FYCLF5uho/hAxtNShCce5Xh0yeveHD+F7HCUJUBvzOtXvuCpUOBgvVICGkiGs
2E0OC04+/KT0lh/1XBvRC2Bz+wqiAQ2/CnnnasoC+VwsoqCyk92jNB1H9XpY5sez
122OpCt1CVXyBMAE0JoeO6svYgYch1nz8cjhUl9CcNbopev7JCjfAWUSWM2qrFnO
fHZnBcj4J6S8xx9Ztt+N
=lvIT
-----END PGP SIGNATURE-----

--xgjcSYp0bZmR6cI7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
