From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi-sc18is602.c GPIO support
Date: Fri, 11 Sep 2015 12:33:32 +0100
Message-ID: <20150911113332.GI12027@sirena.org.uk>
References: <CAFXsbZpdvz2dOq-RMQXnQKSq8YH3YDDyb6wUn87971Ok8hd2yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="StsxD1CZcGPGLZBA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFXsbZpdvz2dOq-RMQXnQKSq8YH3YDDyb6wUn87971Ok8hd2yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--StsxD1CZcGPGLZBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 03:06:14PM -0700, Chris Healy wrote:

> Is it acceptable to take this SPI driver and add support for using the
> GPIOs via the standard GPIO subsystem mechanisms or does this driver need
> to be ejected and moved to MFD or something like that?

A small bit of GPIO controller code embedded in the SPI driver should be
fine.  With questions like this it's often better to ask them in the
form of a patch with a note asking if this is the best way of going
about things, that way if your initial thought is right everything just
flows and you eliminate delays.

--StsxD1CZcGPGLZBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8rwLAAoJECTWi3JdVIfQyRYH/194itPE5Gb/y3NUo5C8+FWi
LbUCIkvovyzpNPS3/zCGUMLDWSRmJB71h0kU8Bzo37R70HQbRstgee6k7S1EQxC1
4pZDbwxiZmupda0al2EobQHjB2q+ULdxDpHzNBIF6GdhgDFRO4VRPU53j2vfC6p6
+F6lXS2AGqyeqi+ZXN4LEmMluq26qJrWaCADkSLBqeHFmx7JY92I1EsnUopCfpNN
n4GidXlVxO8mVD3CWZi3YZEqedvg0PQZ62dS8eFL6zRoc3IyZwLrB8GE6H5iT729
YWOLl/GyHYZTPzJXMBQ4h9cVjva94rwxIMFlABMEPBaQ9tXNe9SuIlTxvPQYsSw=
=HWLK
-----END PGP SIGNATURE-----

--StsxD1CZcGPGLZBA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
