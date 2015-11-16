From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 17:51:12 +0000
Message-ID: <20151116175112.GH31303@sirena.org.uk>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com>
 <20151116135342.GD31303@sirena.org.uk>
 <564A11D9.80109@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564A11D9.80109-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 02:26:49PM -0300, Javier Martinez Canillas wrote:
> On 11/16/2015 10:53 AM, Mark Brown wrote:

> > What I don't really understand here is why we've decided to push all
> > this stuff into the subsystems, it seems like if we're managing to do
> > the matching based on the compatible we really ought to be able to have
> > the core figure out the uevents for us too.  I need to go have a look at
> > that...

> There is already a set of generic OF uevents that are reported by the core
> but IIUC those are not used by udev. Please take a look to of_device_uevent()
> in drivers/of/device.c and dev_uevent() that calls it in drivers/base/core.c.

I know what the current situation is, my point is that I don't
understand why we would choose to do that ("What I don't really
understand here...").

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWShePAAoJECTWi3JdVIfQbwcH/RmG3l7Uiejndi/d+ERkmgeb
rUF+Bm5IgbBKjhLqPK4J0qbAYGf+bKgNCXTm2Nmw9PFkdnWOcQO7DPODeszWdKR8
YyH87j5Pgbvjlcp254flVfJRKwJ+mybSxD7Q6/WRNYNACVMVMLz99JldcB5rSJPp
q6jxtahYSb0WDbcAMs/7CMWXgzAp+sqS4Am4NKl9ftKVvsxsEvLetAswmV69pBLD
VyWaJnQTMgowxVtHvalfEQKXXMCjifab4a+0E9Ab6huOdMdvXtgjP66GTNPveJkv
DTbqGxQ+iGYDjeiHqt0G3MJOgAmOcUCMg2ELe908uzy+hDG0pgESrJL/q+AtX3s=
=QBjS
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
