From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-gpio: Use 'cansleep' variants to access GPIO
Date: Mon, 25 Nov 2013 10:19:19 +0000
Message-ID: <20131125101919.GB14725@sirena.org.uk>
References: <1385296621-23638-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131124141255.GZ14725@sirena.org.uk>
 <20131124155628.GA3417@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UhXv5VeBZ/Y8lRnC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131124155628.GA3417@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 24, 2013 at 12:56:29PM -0300, Ezequiel Garcia wrote:

> I'm just wondering -as I don't have much experience with gpiolib-
> is this replacement the Right Thing To Do?

> It seemed to me that the xxx_cansleep variant just adds a check
> and a might_sleep, so this change won't hurt the general case.

> Is this correct?

Yes.

--UhXv5VeBZ/Y8lRnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkyQjAAoJELSic+t+oim9X4wQAJqxQD67QQzV6/Z69lmKmTWR
tvP8fBb7+gUFQ5ZTc2gX8YcT8vvEx00+SdVTbGeyhZEJ5y9bEEe6aM8TLDPzUl6w
ilJo+WT1Pn7L67lk3s1BZKhKqL8kPUNjLx1ebGc1ZGOi6MQwtFmeUzB2y1YQ78Es
soOaO5H2E00zu6skQd0y4n83M+u3BAKai7W203WH612nBHrcdM6EmpiSBL3YrwQr
0cqgS1PcUQo9u0Dv/G297mgN3GO7JpWPdFSUnzcGvX+BQWbu5JifUp6TpBARCI04
XhQBiy+Q9lPCYXoDfG39XPkWSUVofCoKba0Y/+0jmHyedbHBMxXXYoc19nhdps98
mJt/3YC1qAr/tUKvDIx/GrSgLsIHO4CL5bDAxDdPxF3R0nFRFVODiuOB/gskRtog
TIMOqqcAorvHdTsU0RgvrpTyGxSBJ/dgWgiW2pNcgzApbasTyBL3nk8vFiAgF8Mj
z8GXyXp2PCehH9GxpAYeEFoIrLeeyp0g96LrEBmJovAi0ygYQQR0uot/ag7QVDSb
BG3jGHq3Uh3U0IEoM/xMS3pVm9hAnWkGWf8wtbdzBvPEfvW/I6HOqok50RnuALsK
uLMtmgqNrmWsnMmwEFuvqaf2qmp0ekcp4z3GHhE2IJwOj+7JK0kkcXlCpQR48a4X
Zv706zJM0TtiqRnZmADp
=Li9g
-----END PGP SIGNATURE-----

--UhXv5VeBZ/Y8lRnC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
