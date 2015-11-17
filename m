From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Tue, 17 Nov 2015 13:34:55 +0000
Message-ID: <20151117133455.GQ31303@sirena.org.uk>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com>
 <564A101F.9090807@osg.samsung.com>
 <20151116192434.GO8456@google.com>
 <564A35EB.5080008@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564A35EB.5080008-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 05:00:43PM -0300, Javier Martinez Canillas wrote:

> Now that I think about it, there is another issue and is that today spi:foo
> defines a namespace while changing to of: will make the namespace flat so
> a platform driver that has the same vendor and model will have the same
> modalias.

> IOW, for board files will be platform:bar and i2c:bar while for OF will be
> of:NfooT<NULL>Cfoo,bar in both cases. I wonder if we should reuse the type
> for that and store the subsystem prefix there. What do you think?

I'm not sure that's a big issue - if we end up loading an extra module
with a second bus glue it'll waste a little memory but it's not going to
be a huge amount.  Obviously it'd be nice to fix but it doesn't seem
super important compared to getting the modules loaded.

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSyz+AAoJECTWi3JdVIfQZn0H/0OrT3XmvWQwwhfs/45sbs7Y
CZXqCz+mseV+wqVdTusWIK92znsxf2FfeISNIE8E+/p4vGGdjlhavCa8nd1QucEW
S0Svzkm1nz0eMTQHCQsFK/59/zG/Nux9GqN3dQlnOokNF+m1GYnhAQpRmmfeaOCF
8pd45W4HaYzuss7wswETlRMNuKQZAJ1JcCEmqriKBx/9fEy/96jB5ewrSTkn5tTc
e/GJPUowcPYNFkOB5wKAYfIlqdiu+I81NYI9RWGf9tjj+DKoa8f3HXpMd6iNctZU
4O9PQOCOIWXT1gEXwl85KfRBVEM3jhAKzzwnJMgJN4zm93asp75YCMTPg2NFeG4=
=QKyA
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
