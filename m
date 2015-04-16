From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: change timeout of polling driver to 1s
Date: Thu, 16 Apr 2015 18:57:20 +0100
Message-ID: <20150416175720.GC6023@sirena.org.uk>
References: <1429170693-1718-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+9w2cAX2VMqUZAN"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429170693-1718-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m+9w2cAX2VMqUZAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 07:51:26AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> The way that the timeout code is written in the polling function
> the timeout does also trigger when interrupted or rescheduled while
> in the polling loop.

Applied, thanks.

--m+9w2cAX2VMqUZAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVL/f/AAoJECTWi3JdVIfQlOwH/j3eRDwr6RdE4Pr1OlRKUOhR
qX8BQFBSI/nf7zBw+0yE8vv2nHGJqPaa11IaKzHiYIuA0tLmabRpd2n2ks93QI8I
ewKO0q5h+SiXpz9YbxduG4JF+rhCdI63nfcDd7mLQmyH9tkRKJ/fwU1xuqK0Yrmq
91iQ94MJY3lW25YWnigjVpaZMDXT+OvHIJpgoHYWWEeDBOlC/PwZE0m9aeDgyhkx
VD6M3B+e5ba7ogr3BxBn1HLksQn+/Ck/jmVgjiwVMWpuSLltbPEzWPHkTnMLycSA
zbn+RiUSq0WWeL8mVBKPrehhapt3ZhgxdoTKOb7CT/u+V/1aKCni//xVwibWvZc=
=13Ke
-----END PGP SIGNATURE-----

--m+9w2cAX2VMqUZAN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
