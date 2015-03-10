From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/4] Cleaned hexadecimal dump
Date: Tue, 10 Mar 2015 20:52:53 +0000
Message-ID: <20150310205253.GS28806@sirena.org.uk>
References: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-2-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yE3esYaFu3yg/VEv"
Cc: corbet-T1hC0tSOHrs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426018353-13442-2-git-send-email-adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yE3esYaFu3yg/VEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 04:12:30PM -0400, Adrian Remonda wrote:
> 	v2: Fixed coding style and removed unnecessary castings
> 	As noted by Geert Uytterhoeven and Mark Brown
>=20
> 	modified:   Documentation/spi/spidev_test.c

Applied, thanks, but please follow the process in SubmittingPatches:

 - Include stuff like the above after the ---
 - Use subject lines matching the style for the subsystem.

--yE3esYaFu3yg/VEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1mkAAoJECTWi3JdVIfQO08H/1TnYiBhaoEj+Jy2T0vTPCiA
Mt+595fp32PGW84dLhWqfWHk/82KTXUB979NokF8j21xAWEsUZUjYxzk9CGkakzf
bS5X15+5jjof9k2e+BAm43Rm+nr0aTUv9O+TXW+Vta9N2iFkcKgSz163ZehAFp68
fUASrZD29YVbjmn8V11wNQ/1rUwbBkjf6CpTHMoS6RkiEMA+8Gx3XqkAOYhNy+TE
td54cZLY4DVwuMVLfaQ94+VtAedsdwFLMFHbrSQhFVwuYsijEyJfyl96mg7YjrWI
JsiN7IavmFdvICvvvvYGzWhLm2PiR+/qLZF3TgGWyF5r7iy513y2mi/wTq/VDfw=
=p/A4
-----END PGP SIGNATURE-----

--yE3esYaFu3yg/VEv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
