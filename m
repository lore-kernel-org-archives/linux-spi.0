From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 09:00:57 -0700
Message-ID: <20150326160057.GQ3572@sirena.org.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
 <20150326153855.GP3572@sirena.org.uk>
 <551428A9.9090604@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5AmtYbcgdBTTPS58"
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>,
	linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, open list:
	SPI SUBSYSTEM <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ;
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551428A9.9090604-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5AmtYbcgdBTTPS58
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:41:29PM +0100, Nicolas Ferre wrote:
> Le 26/03/2015 16:38, Mark Brown a =E9crit :

> > To repeat the feedback on your previous big endian fix: I've not been
> > CCed on the cover letter or any of the other patches so can someone tell
> > me if there are any dependencies or anything?

> Yes, there is dependency on a common header file. So I think we should
> keep the series grouped or plan a migration path.

OK, thanks for letting me know - Ben, if you're working on this stuff
*please* bear dependency issues like this in mind.

--5AmtYbcgdBTTPS58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFC05AAoJECTWi3JdVIfQcDwH/RM3CCFqvjxpPgOjoSb2J20f
uQjpg2RW0dfmNP3mDz6sIPOKoZTV/74brtdXUmpnMr0Vsb/9lZl3SCDR88f5/hog
IIRKeo8YiI79uJFIvPgSksPhMV24aY/4Ymo+F1SZRnjb0rP4u8dw8zIopFO6fTn9
M6m65OLQEPYl46fjwbOK3sE/92wiBc/GdkwCSumq5iu5gQG90ecquGmvOb80o2SF
mQ61eHW7ohdIhjZdJPNzQ6dZxptIxP9nTusg7qlfKMAa2paNW0birb34KckPzpzI
BDlMXMBR4ZCkf7gNT7/ORWbmhFHcNDdvgv0wwl5tDobUkXZ6F9AkPcUjo0WSrgU=
=/c91
-----END PGP SIGNATURE-----

--5AmtYbcgdBTTPS58--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
