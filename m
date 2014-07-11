From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 13:39:49 +0100
Message-ID: <20140711123949.GM30458@sirena.org.uk>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066677-12858-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcSASNCKFtrdv99s"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405066677-12858-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZcSASNCKFtrdv99s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 10:17:57AM +0200, Uwe Kleine-K=F6nig wrote:
> Olof Johansson pointed out that usually the company name is picked as
> namespace prefix to specific properties. So expect "energymicro,location"
> but fall back to the previously introduced name "efm32,location".

Applied, thanks.

--ZcSASNCKFtrdv99s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv9sRAAoJELSic+t+oim9gz0P/icOIW3qSSwG+T7ZIhIgXZvN
LsI13gvaW1n9UilXU+MdAsRm21GAIkw8J3IxXHpFLnZAqXkrqiDUhFI2ZP59Bd5s
IWGOP33d4AFbgRHj24gKs1PfHc7EbHavbtytBZ6aQDbPqrT3I0yBXCSJGqj3RjtE
Y7VBCe+DCK+r+aonHQopENYf/rTzjGXsJvd7CyN2qyvW3mwGOaFigb+MKR691HC3
CPBpqhEDCTvPJEjJqnR7uS7cX8gcwkESVdWsYjmbRr9wjvk8r40EwDOb91N22hU7
FWMbx7uh4gNwH3NQGfstZJBaVI0gkxhAukXW4iwcPUZhQVHiOb1YQQfhMA6nqYvx
wo549nc13bzUuw+4sAebEQzbnYx1Mo5hMla8ts9XXMUVHGU0imEM3kdt/AOf08jK
UgNh3Phpenmfl0bNckSI9BjJoy0vA+LJNIvu79zrUvj+PeJ/5PgaoDfNM+RGZqLo
skQFq3b1V6qIcz7NCzSOnWUYfFVR9Lolui3HbSDSGzu5GxDWSKkTYJDsTYT/IwlC
q4nxBgjaNTfpnMadUmf37XWv1PSx4Z6972hNa2GGRz2kzScXFouJ7ciOQCgIh11i
pqAXxUIqHzp4N+uG5p2zxAZiF9codJcrWzOdjybw0BpXJ/I44bxm/Pyjyr5m58gk
FS+9RMHYxpKr7V6GJC7O
=wL/w
-----END PGP SIGNATURE-----

--ZcSASNCKFtrdv99s--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
