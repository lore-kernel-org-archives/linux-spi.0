From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2] regmap: Add regmap_pipe_read API
Date: Wed, 20 Jul 2016 17:17:57 +0100
Message-ID: <20160720161757.GH6509@sirena.org.uk>
References: <c64a366156bd450cae2419890e2ec06b0b09e93b.1469026858.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c64a366156bd450cae2419890e2ec06b0b09e93b.1469026858.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 20, 2016 at 06:08:05PM +0300, Crestez Dan Leonard wrote:

> Changes since V1:
> * Improve comments. I think "pipe" is the correct word here.

I really don't.  To the extent it means something to me I'd expect it to
have something to do with a normal Unix pipe and be pushing data into a
file or network socket.  Something like _rep or something perhaps?

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXj6Q0AAoJECTWi3JdVIfQgwwH/iRH1H4Yw6MIaVH2p4GyO7Ew
+pna/wnK/CuLfTSdjw55Io9GTkFJMOBa0kYL8AAmMN4RRjVBE0SEEiIwt+7AdIQH
d57jKsZziJz9F94EL/39ZNbpWEqq8ccOxWAh7ZqCYZwsIWf5Hya8rhH1ztx4+Sjv
yFi5wIfhs7kI0lf5O0FoCwPxAmzpL0NK+6BE/vILFMuhf3nbFnC+VROkVf/PhjZM
PjeyYSL/+OovGIWmmYJdfrhb5ozbj0KJUmZWDGq0U+h6cvKxxJ1YBHGuNV3QVCLv
NpuuWmTg1RuyF7LJi7afvTT/tgh89C3CSCfohHruyAwagUd+mc9epIXebcCIko0=
=nrs7
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
