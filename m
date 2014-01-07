From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Tue, 7 Jan 2014 11:13:43 +0000
Message-ID: <20140107111343.GW31886@sirena.org.uk>
References: <1388388474-8662-1-git-send-email-b44548@freescale.com>
 <20131230134217.GC31886@sirena.org.uk>
 <79669bf1a15247cb95a2609bad5e9c5d@BL2PR03MB163.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HyGbKHmOkFhlsb0n"
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <79669bf1a15247cb95a2609bad5e9c5d-AZ66ij2kwaYw6E1ICcNxleO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HyGbKHmOkFhlsb0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 03:54:25AM +0000, Chao Fu wrote:

> > Seems like there's some whitespace changes crept in here and elsewhere
> > which makes things harder to review.

> [Chao Fu] Here is some coding style not in standard in former code,=20
> should I take this opportunity to modify here?=20

It's fine to fix things like this but please do it as a separate patch -
it is much easier to review patches that do one thing, if there's extra
changes (especially changes that aren't mentioned in the changelog) then
people reviewing need to check harder to work out what the change is and
that it's doing what's expected.

--HyGbKHmOkFhlsb0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+FkAAoJELSic+t+oim9TiMP/iCWx9lpJyTpukNINgxOrQV6
nYEekj4zDLnl9S09SpxHHt8Txpt8LDdO3Fhs2BSxEhCQD3tUkLPY0YEyf9c0eQS2
DKmpf6YGwdQpcXN9V4cka5DZyjCsynpRgD144A4o6Hd1KVHLrgCGF5k4SAeVMxRH
3AWdyruTva4ru15znU5n4bPsmhPLZnwlLm56Bc4THL5uFg4X2b6yBPqSp81odoWF
gqrN32UqJVtwUone2KxA+B+9M03/3GtsoYc9wqDSVqYCFlhjBTo6j6tMKaHx/Hqa
fwMnAjmQ5xn/WRcweemzo686eeZNIf/uhIf0QdLJRCmVd5DAHZUQt01dwG0hf0Fk
QVhsWaRtqaMT9qoWbwSjrqHvSkNtmEUIpoh+RbPAqxi42Wk1qZlKM5TmdNUwsi26
MrJwPExUY7Ge++lEYQcvDv4LOMEwxLM+RDFJaAfryNw/EhbSRwCsTCh0O6dc+cN0
CzHsDg74fBgudRiohiFVjgx0JAQi1m8TKlepaRdxG3gCBqz1YQfGI5q7oT1p4Qcm
+Vt2i5flwDA06H2wSfBn/rILxBRdbidWHdD4Frc4azTDyOFEERj8Rm0jniwyIA6Y
TkHtrnMu+D8SMSqyDigkEFoFdCKrZBszmbCScJDTmOH8+FxsOdQFpwfYSqGKukWQ
T6gtGJQsL6vvmTdeq4ID
=CHOl
-----END PGP SIGNATURE-----

--HyGbKHmOkFhlsb0n--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
