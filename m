From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] spi: core: Introduce devm_spi_alloc_master
Date: Fri, 31 Jan 2014 12:12:15 +0000
Message-ID: <20140131121215.GB22609@sirena.org.uk>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ioqcch2Htvy99P9q"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391163792-21819-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ioqcch2Htvy99P9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 11:23:09AM +0100, Maxime Ripard wrote:

> This patchset introduces a devm_spi_alloc_master to the spi core. While most of
> the drivers have a spi_master_put call in the probe, a lot of them using the
> devm_spi_register_master function are missing it in the remove function,
> leading to leaked resources.

This seems confusing - the idea here is that if we've handed the device
off to the managed function then the managed function deals with
destroying it.  Note that spi_alloc_master() says that the put is only
required after errors adding the device (which would be the expected
behaviour if you look at other APIs).  Looking at the code I think there
is an issue here but I'm not at all clear that this is the best fix.

--Ioqcch2Htvy99P9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS65McAAoJELSic+t+oim9wJQP/R+2y1pjZriPrmm9Zc4829xJ
yGSBgVmQc7h2Q79fey4NliPn/HHi0NHH7RIobgSExa0sDwQYeKmQCepqQb0DyMXQ
kxJ9JzZrTJKtP86ox9JYK4yMe5OLAt+tgEPfJ7jCpF0XUmAQGXPU2hvnfPyPOh5A
ZVyO1fVeXPOkPMFvl5PfURS33/V8mPbvhpliQLRIn1WS5i1hZ78QvLjjDwDCWx28
jwJ563vV1LgErH1rhHKF6CbohBVafqGh37dhYCeQ8B24bpiOuTrkpHxpvw9NT6Xo
HlPTbQsv9Yn+LvvmWr6wvc6bTgcIHy3jT4GwYY8Od8Li2c5cKFhRyxYpRed221II
swA1FCQed9mXRBv6Ox+WOWlTNPz98nLgZ3wquCNUvnTmujS6W4NOBMaDctlzdsIQ
m+dUvfgGDS8Uliy5yBEn7q9EwZ/iS9i4MplbYs8UJNR1P7ieTWi1B3u4Vj9Dsmh8
SI2DzmUCEJLWsQeo4qwkh+V4te/kWnx/FW9iUJ7Pv0TI2pFseCpxR6NpYqUHkE5O
fc7TdU2esiVKPAF8+z/Pgyf8L8h5vq8MZ5gzPHZFT/+8Z8Dh+fWMdakVfiIU9CgG
dPVHKmrqahuz9u+acFWAFMTM/CJ8qLj+jpCNf0A9vN2FIA10zF+V+ZXnjC/YE3Qi
hEo/ZhsP/oECMKSOglbN
=O2QJ
-----END PGP SIGNATURE-----

--Ioqcch2Htvy99P9q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
