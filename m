From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT][PATCH 1/2] spi: octeon: Remove struct octeon_spi_setup
 usage
Date: Mon, 3 Mar 2014 12:00:08 +0800
Message-ID: <20140303040008.GF2411@sirena.org.uk>
References: <1392802252.7991.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8TMLq6GPUuN4DysL"
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392802252.7991.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8TMLq6GPUuN4DysL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 05:30:52PM +0800, Axel Lin wrote:
> Current code uses struct octeon_spi_setup to store max_speed_hz, chip_select and
> mode settings of current spi device.

Applied both, thanks.

--8TMLq6GPUuN4DysL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE/5FAAoJELSic+t+oim9hCwP/3o2UAVIItilEdDluHGb+YVX
NHCDX6kl0bFmaE5vb3Jmi61amVhUZKd18gYVcpjSaC5rD4FcFXbSxrhNbACTlvEO
IBIVhBtA9ggena/VSt2DI8q8TSY+wAJnD5HOk4GMdJYT7DmN6uYpuCwo4o5AY4o+
wbiK4UMbcbYYijVA66meFESd+XkDNAvJho1O/lXd2d05O/LaHz4afwrSxh60yooT
MbCRhF3abrXO5+RKXR7AV3Gf88NJ6SgJ+MZVWkH0jaLsRAgSJJygQ23kKRH7vTLe
PY6IGhI8TtE/oqvidm8ToaxuVOSrbmgBURR1pZtTNBG04ptu1JH1xVfNs3RL1Aiq
+XLB/XPJkl4vRBmZ3EfWtzu0BAebx0x+ZXkF96bM4jCKpx7GN3yhkh75Wz+bMvc1
r/2oZn7gKtEXaJhPxi8CiCcTsQbCAglpR16MnKJlUe7hixy/9j30xXHxYbKVBuub
zpI2Mp/AQSYg3md9AY8N/VED1WOL0+q7nQotfYrA893DOS9v0Z5+Xp0LsKm6VUpr
l6LqDwLkcIKpiuddyTaTfk2MXKuXIbQiStk5PTs4Pf1uTjFTIQh0F7DoL1fbg3lV
buQm/eLnGXVIUgLt9FJUe9nZJkxkfV56LrJ5MGFr6b+6FqvXYLOPzFAY0KxC8Zg2
30/ljB53e2Us/5QMPYgW
=JJjb
-----END PGP SIGNATURE-----

--8TMLq6GPUuN4DysL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
