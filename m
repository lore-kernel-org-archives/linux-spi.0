From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fallback to interrupt for polling timeouts
 exceeding 2 jiffies
Date: Wed, 22 Apr 2015 20:50:45 +0100
Message-ID: <20150422195045.GL22845@sirena.org.uk>
References: <E9247B42-11B6-4032-A6C1-1FCEA3EDA2A6@martin.sperl.org>
 <1429687984-7350-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnxXMyWEPIZsopkG"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429687984-7350-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RnxXMyWEPIZsopkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 07:33:03AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> The polling mode of the driver is designed for transfers that run
> less than 30us - it will only execute under those circumstances.
> So it should run comfortably without getting interrupted by the
> scheduler.

Applied, thanks.

--RnxXMyWEPIZsopkG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/uUAAoJECTWi3JdVIfQnI0H/2odGbssDOjl/c1D1dq3FW6t
d4MB3wBgFS4LN4iwSwt507Jaj1aMbEkI6K1gESX3YouVGMchBwSaALfu0Jsy6jrN
8bwYNj6XaFOVF6RjhosRqmU7Ct56JfNLL6x6N1ZTz102R40FX9ShbE021RGid4TH
u+jcaCoTmmGh1vf33VvKJjqxoG+sSGnZp1XU68c8mjVRi/t4BBmXrfS08wQ+g2Ok
5bHR+ITenAl41UIptTRZBXDxJxyIP/KxEm03EyFsyahT0jgTrNZzy9vd9qgR5Zo9
F8U1muTa2CC9XkAfKM8e257o99P3LJ3+bFwkLl3NnxvTuHuSIszvAjDgXj0E1Ik=
=wmKa
-----END PGP SIGNATURE-----

--RnxXMyWEPIZsopkG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
