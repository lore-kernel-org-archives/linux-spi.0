From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: tegra114: Convert to use master->max_speed_hz
Date: Tue, 11 Feb 2014 12:09:13 +0000
Message-ID: <20140211120913.GI13533@sirena.org.uk>
References: <1392040096.4191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392040096.4191.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 09:48:16PM +0800, Axel Lin wrote:
> Use master->max_speed_hz instead of tspi->spi_max_frequency, so spi core will
> handle checking transfer speed.

Applied all, thanks.

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+hLmAAoJELSic+t+oim9H4EP/iELWZuLPE2AHkApDJ+SjGvs
Hf6AmNixYMPyT7DZKg4BSii2EtqHHPabDTqe2sY7JXMd1GVMgOU+Dmh+p1MDXPvO
7XFOjwtAQl67wl1D9pwKnbhQWe/YH8LwKFh9YuwSBHL+Yp8M7nvmqXmmCHHTNEFP
KeqIA3z5uNpWl5cZGblkcZlnYYTtRY55IlnqLHQCRRelR942o6U3bAWhPJssRZms
RnQjztZdUero9SkZqybeX2IC8k3213KR0qcou2mt3fY4US7TQfL1+iv84cmpdbWZ
2tIiLh1YZUduQncmPISbp7lCubJ/glEPWnw4+2z2NSnudH/jXv1vJcJcT86Dltnw
YSqIItWraosrDRcG/Wy0e7Jau1rFrbTp3NZdXUe9q2F7E7LA+fsSYHBFB02n9TXT
MyYRKUrRAl9mB4osx/bUP3DclQOLcbXKi8eGs2SsKXqExcXzpymjX+jW0j7K0PZb
mNYVSvYPcCIg2QOKOIJF4eDNF46AG5eTX010sBm5hT+GuPE7pPryrI7lrw3lZE/P
Iu166ifreKlsFfQbmhU7KoLb9FxzBE6he6FnIHxy4obOkl436oM0VhnGOZ3HX9dZ
uRupm9Nd3TPC+BH7RjJrUZ3KJh/OBHtCiJe59CUvxi3ZVjEXLCPxBP2m/Kt7qfrm
0fatlPc8BU3fSpuSlnPC
=W8+Y
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
