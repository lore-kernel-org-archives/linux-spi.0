From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Date: Wed, 9 Aug 2017 12:44:21 +0100
Message-ID: <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="76oohoz2fusi4hjt"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170808225247.32266-4-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--76oohoz2fusi4hjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:

> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.

Why?  Is this assumption reliably true?

--76oohoz2fusi4hjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmK9ZQACgkQJNaLcl1U
h9AHSwf9Fq1OGMyZ9pNQve/uU1k7zR3YCjYuG4FAiLJ7uyu52Gbu6Jhy2kZNIn4Z
CthKUBdR/SdY6Qfhm0kk82z5Q2Jg6gc0FNzVPjXHe0nRL6oFvGyO8Zs8UL0hfJsn
8TMv7S+ApJMSjM7Aayj/Gx1bCq1GBG2s9LLhllMVfOgY0JVh5ofTzy4Egt1cfY26
SK/DTBgpOJc66xrLAOV7Z6GluBSvyOpFvoobbH8YvKEM+iV+QALKZ4u4UjKI8UJG
BNUTEqnljsgLIL8wvoEHFSwh9DSenQbKdzI1sUNkFF0cA7MnrrSez3vfuigi0nZo
Cwhde95F1WGQNdz3R2Cf83JlTMrOBw==
=fsAd
-----END PGP SIGNATURE-----

--76oohoz2fusi4hjt--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
