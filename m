From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: topcliff-pch: Convert to use master->max_speed_hz
Date: Fri, 14 Feb 2014 20:26:58 +0000
Message-ID: <20140214202658.GM4451@sirena.org.uk>
References: <1392042400.9602.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g6DVDhPhk1bqxDrC"
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392042400.9602.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--g6DVDhPhk1bqxDrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 10:26:40PM +0800, Axel Lin wrote:
> Set "master->max_speed_hz = PCH_MAX_BAUDRATE" then we can remove pch_spi_setup.
> In additional, pspi->max_speed_hz will never be 0 because it's default value
> will be set to master->max_speed_hz.

Applied, thanks.

--g6DVDhPhk1bqxDrC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/nwPAAoJELSic+t+oim9ugYP/0AUa+dDUbQBP8SCJE4w6aFL
09Kz1xMX1yaircgXAC9gB41waOaGu1AruPSIiAlM2MbDhbmKiIKl6+npALewvzPR
kV+gfloSnh3AFRYRvb0uVGAVgBu8IhRZ2GE17r1efQ0/yNd9G8SoKm/SN270KOTu
3/j2OlXC0JkGbeORu+YQi6E3zY0v6zJNqGlj/EePcnMmIYRSwSdE++PGKurC0Tyi
mAey5iGgwRcIYLxJ3Nm0H2VNJ8Tg0JOdWa5pfTE9Y8u2MrMyQVUwA/YkCnnodD22
IdXyv3C8s8NgJZm2P3mbMKM9K3WSE1L+IDKvh9YLmzlJ1OqLfZFdP+guaQkO7rPN
+jP//J7uV3CkcwXMzdx1N3is+TIHYZ8XNvbL8vp/ELqvgPQfGQRxO4A3zYbqjCau
1I6Eil4Ao33T4bZgf9GspVyiJvWhqcJwnRprIcXRah9i26945Q7ixH9fNrlOLO5C
96es0xznwfZs0Q1piSyBzQxbmUOSGTnshNy5tMDfg97Zi1DKDue36xOxLWQxupWK
bcIQwP7ufEgnnpuWJZFmgA7849klfg3zCCdg9k77dbJ4EV8wxqWDHDFLJoOjMAGC
0+9HzcaA2ti83pZ42+TxZd9Ni+KpkdL1MrmaN71WY/n8NikqTfUIaXkyE7GdJQjr
vC5lgF+4ZXw2CKmGO+j8
=jkYL
-----END PGP SIGNATURE-----

--g6DVDhPhk1bqxDrC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
