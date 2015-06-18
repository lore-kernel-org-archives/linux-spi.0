From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Thu, 18 Jun 2015 14:49:18 +0100
Message-ID: <20150618134918.GF14071@sirena.org.uk>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
 <556EE446.3060407@metafoo.de>
 <20150603115319.GF14071@sirena.org.uk>
 <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
 <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s4QZEMnjKRGdPWeD"
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B3BA7701-96E1-466A-90EA-121E2A85F851-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s4QZEMnjKRGdPWeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2015 at 02:54:35PM +0200, Martin Sperl wrote:

> Now that I am back here some examples from /sys which contain multiple values:
> /sys/devices/platform/soc/20980000.usb/pools:

The fact that other people have broken the ABI doesn't mean it's a good
idea to introduce further ABI breakage.

--s4QZEMnjKRGdPWeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgsxdAAoJECTWi3JdVIfQeuEH/RETweu5Y3nWwnwMK5hVx/Tz
sSY+6GBGG+o5TTOh0kzuYpJqE6Qo/4GQZHl1b5ZglydDUZOv698SIfcs893+9k1C
rXBNv1rhFO332Jn/+nHdi6V8W6tBfvTZ2yY8KUlJ/Ip4462JHibd3MWv0UwHaYK4
b/NzO0pOJ9rV1DSRet6OfObNvQ/PM+tdQSxe8si6d7EifUs2pP/ycC/M80AnAr0W
KlEmNaY/zW+JYsyD9lKWdcaeG6iCK7NjotUQbbpRH78o8oKE1+4J2nS9epJfBjFY
e4DwRklTJ8euYa+0EO+05QvAr/NdkB5bKaus2abvpTZlbuzfQQhmbg3PtEC3Vs4=
=B4Yu
-----END PGP SIGNATURE-----

--s4QZEMnjKRGdPWeD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
