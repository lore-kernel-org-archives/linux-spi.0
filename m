From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Fri, 10 Apr 2015 19:51:32 +0100
Message-ID: <20150410185132.GU6023@sirena.org.uk>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/7Onh1QCWCkNlplT"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428340592-3196-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/7Onh1QCWCkNlplT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 05:16:30PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> In cases of short transfer times the CPU is spending lots of time
> in the interrupt handler and scheduler to reschedule the worker thread.

Applied, thanks.

--/7Onh1QCWCkNlplT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKBuzAAoJECTWi3JdVIfQXxoH/1duiMjVeIFc/IxzastKur/P
u+5RA121dTzK1zfjFijC8ueFbqqa73Akj812+orFm667rtzCWrWNE4BsWjGg9Rfz
/dhaqqt1vJXDmLfajMb9qLPCNl/xTOlTcceEuKImgzZkLAySg1n/Vx1GyeFiWwtj
U0wplozmQFv2DffwCx8TkewfmUmcgN6hbjUtMK0qrdKqfmSGf3Sq9S8LQOLGWMET
djRE9bgz7NjqDPoUXwtVC2iL6EdrEk/4aenln5rekFtYrKodpH2y61Z3OAGo2UBI
0bwbb3ob3rGOhmC3a8Zm+bS1pLwEtOLWDAH/kslSai4yj9izR8vtRMwdLsjc1h0=
=mrc8
-----END PGP SIGNATURE-----

--/7Onh1QCWCkNlplT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
