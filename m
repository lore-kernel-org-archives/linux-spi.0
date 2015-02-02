From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: cleanup wait_for_completion return handling
Date: Mon, 2 Feb 2015 12:08:50 +0000
Message-ID: <20150202120850.GN21293@sirena.org.uk>
References: <1422790931-4794-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APumMR+Gr8ZVihkF"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422790931-4794-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--APumMR+Gr8ZVihkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 01, 2015 at 06:42:11AM -0500, Nicholas Mc Guire wrote:

> return type of wait_for_completion_timeout is unsigned long not int, this
> patch adds an appropriate variable and fixes up the assignment.
> Further it removes the else branch as the only thing it was
> doing is assigning ret to 0 - but ret is never used thereafter so that
> is not needed. As the string in dev_err already states "timeout" there
> is little point in printing the 0 here.
>=20
> directly rather than adding a additional appropriately typed variable.

Your commit message appears a bit garbled here...

> Patch is against 3.19.0-rc6 -next-20150130

Which?

>  			as->done_status =3D -EIO;
> -		} else {
> -			ret =3D 0;
> -		}
> +		}

This appears to be introducing some whitespace damage, please fix and
resend.

--APumMR+Gr8ZVihkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2jRAAoJECTWi3JdVIfQBSUH/jeEkre4Twd9svCtYBCFaRDS
oeRrMf8V0fl0VjocW7WOYD4s7KVhSjyCOxBg2GEtOTK7wj1nanumgDDjDE1JBsNI
pBIRzACYBMzxD9tely2IROaKsv7W/GOGZs26+IM/fp6ZGZXIWHcgiWxowNHoFpOp
kfVmiGN9+Veu/9NmyuVo+akUx4OuOs6EVTLnNAc7fAz+WCAicVRBX3WVp25BQtwI
pGL0RoT+5Yi3RXGA63fVA1mUmgLgcpgkWAPe8t5s5zHDQPriVXrA7ZRv9ofM13fj
LIuPrq78VcKwp+XuaF7opYXzzL//VdGlbMyZq/7+wak94Okjd4ESYcCG9iRdlAg=
=azFs
-----END PGP SIGNATURE-----

--APumMR+Gr8ZVihkF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
