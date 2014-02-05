From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Remove unused pointer in
 orion_spi_write_read()
Date: Wed, 5 Feb 2014 22:12:26 +0000
Message-ID: <20140205221226.GJ32298@sirena.org.uk>
References: <20140205222301.14fbb441@spike>
 <20140205213116.GA12659@sirena.org.uk>
 <20140205225421.013da54a@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140205225421.013da54a@spike>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 10:54:21PM +0100, Christian Engelmayer wrote:
> > I'll apply this but please follow the patch submission process in
> > SubmittingPatches, in particular please always CC maintainers on
> > patches.

> Thanks. For trivial patches like this I tend to rely on
> get_maintainer.pl which clearly pointed me to You. I'll put more
> investigation into it again next time.

It should've listed the maintainer as broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org rather at
linaro.org which was where you sent this - IIRC you posted some other
stuff recently which missed my comaintainer on that subsystem.  Checking
right now I can't get it to give my Linaro address at all for that file,
odd.  It could find that via signoffs but it seems to have squashed
those into the maintainer section.

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8rdHAAoJELSic+t+oim9aKgP/RkPFNePF9Cj6hEqHqFM6X6C
c8xgMlxzVNQXY5jMdrm65Z8QDKjZlIRRCjziBVfYBWRJtynrP/1usj5GYI0g6+j1
sESQw4GcmMsy9pmN/JJpG0ilqBfQooYRVYBUKQ3zyq4mc2mkxdUFw6kuxIdhxB2F
KbY3yBGGz/IdkxP0ciUMEXYZcz5430xVp0w2KSA409I58p55bq8hHkBcGXl4vC+D
ZE6eCw6ILs/nRQQqjHYSi/6vQDMHA6QzlOoh/hEq7jEWXpBzxhbCNp/0RbqyZ0oK
5cmUhSTZhT/ZGw865T26O/YCTnLIPIlzapUuW+u3lPU82zhC1Rs0KKefqPMJPga8
IDRUu43P5qc58xSU5YSuQN3j6PZTxcxzLwZ3SVh7waO0KBeCxPss6Mkndg3tPpzD
V6UDtva0u2IY6yYzD09nAEB7npbyuWqJyebX2AlFX3UvnpO7gzehWKsSnE13JtOr
gehAwT0eKbAWQnmmooJ4KqMYhgk8Q+0oXgeFDyBhWI1qXbbUgaeFE9dZOTYVc8GP
kX6wg0QZNfeMQVqPG8Ve0MQ7e9fK6/iT42MtJzFdpph8rBJcm0i+ae5VohTnbC/R
xmwEta4Zk3Pr2XwKwTPUnez6nwZf+fyB0I2dZH3wnReE59qyjMgaLaL/2UebsD+Z
x/oN3OFwgFmSS+NZQxbB
=Fegj
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
