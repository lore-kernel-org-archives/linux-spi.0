From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Fri, 19 Jun 2015 10:53:46 +0100
Message-ID: <20150619095346.GG14071@sirena.org.uk>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
 <556EE446.3060407@metafoo.de>
 <20150603115319.GF14071@sirena.org.uk>
 <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
 <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
 <20150618134918.GF14071@sirena.org.uk>
 <20150619113539.04a7fcf2@north>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ZC8HHDsDfqlD0R9"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150619113539.04a7fcf2@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5ZC8HHDsDfqlD0R9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2015 at 11:35:39AM +0200, Jakub Kici=C5=84ski wrote:

> How about putting this file in debugfs after all?  Mark suggested it
> initially but the conversation went in other direction.  Martin said
> that his main purpose is to help *debugging* performance of RPi dma,
> so it's a perfect candidate for debugfs.  I can't in my mind see any
> use for this information on a production system to be honest...

That's the solution I'd been expecting.

--5ZC8HHDsDfqlD0R9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVg+apAAoJECTWi3JdVIfQWW4H/03LOjaX0gJ5SPaK392hlAj1
z0O8m+n80rJyZ3ej1IAZiGFMMxIfvpvf7O1oYrwF9Ab2cTOSbix0EVxAWlWGaG28
DS6IZn8Vx5bD1TQRie5wEU55mznu5S8fbLvql2uRWY8xDbXPpkrHUudjd+bDLdU/
4GoqyWQdO6onEM+uO0Ku3aBe9JbwmZvfd8UzUe0zCzJdeRpp0YBsbe1VO7Xaz7Hr
QKA8HXRCHk+bsTjK2oOJhzd4oXsvrmQUnF+mMA1qnS3NZ1R/xJBvHrbmKNUJECHd
7AJzbdgGcgo8lAANYE2SBt63NzUuhsGoglxxkx0ojcsKvb0o5YXXURX2UBhI9z4=
=H8vc
-----END PGP SIGNATURE-----

--5ZC8HHDsDfqlD0R9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
