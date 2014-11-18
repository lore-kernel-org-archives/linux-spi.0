From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sirf: assign spi_master's max_speed_hz member
Date: Tue, 18 Nov 2014 14:45:11 +0000
Message-ID: <20141118144511.GM22111@sirena.org.uk>
References: <1416237423-3606-1-git-send-email-21cnbao@gmail.com>
 <1416237423-3606-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37nyS7qXrnu4wN2o"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416237423-3606-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--37nyS7qXrnu4wN2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 11:17:03PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> if spi device has no frequency, spi core will setup the default frequency
> to max_speed_hz of spi_master according to
> int spi_setup(struct spi_device *spi)

Applied, thanks.

--37nyS7qXrnu4wN2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa1t3AAoJECTWi3JdVIfQSZYH/jenndckqW73e3anOgM5KlJ2
EKrE9ZXxWrorLpbIPfR+TWKqgSbwDfQ/AmbdKlHpekrv9UL4i1KJAtrjYGqYab7s
WOPppKjIsCwCl2gRZ0pAPAO5DcgmcZmu3pNMChtd/nMqAdJ9KmA8PEEcCqL4KmJF
awsw+YS8cT8UOwS34MqFdvbWz2vWNHPSDP0PbyG/TdsHSuvtnl6KTUyRfe3roaar
UfsXPZCgpkTFAOaolsf5+fEOSm6DVebV2tKEY9F+GFrqASmnAqtzG/K5N0C1oKjG
PHCv967/OpAXN9lWByPn8hJA4NLmqReQWSIjtp6ec5F6X8C+4Vyu1Y0deY0tmCM=
=fvh3
-----END PGP SIGNATURE-----

--37nyS7qXrnu4wN2o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
