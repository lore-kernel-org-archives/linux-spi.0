From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken (was: Re: m25p80:
 Commit "allow arbitrary OF matching for "jedec,spi-nor"" breaks module
 autoloading)
Date: Mon, 16 Nov 2015 13:53:42 +0000
Message-ID: <20151116135342.GD31303@sirena.org.uk>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151113234857.GK8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2015 at 03:48:57PM -0800, Brian Norris wrote:

> I suspect we'll have to fully support both spi_device_id tables (fully
> supported already; if nothing else, to keep wildcard matching) and
> of_match_tables (not fully supported for module loading), and in some
> cases, the two will have to stay partially in sync.

What I don't really understand here is why we've decided to push all
this stuff into the subsystems, it seems like if we're managing to do
the matching based on the compatible we really ought to be able to have
the core figure out the uevents for us too.  I need to go have a look at
that...

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSd/lAAoJECTWi3JdVIfQtJUH/jbmIbB6XcwRx0kknP2tYack
5kHcSwZ+9K2tR1EL3sA9IFjgz2RRcC+fLcPjWgVvcgX0Yq3Yju/GQlNTHSywW88P
q5yDyAPmUblfKRnul9YwpCEd3jPhe0aL0QTEYt9sE7d5/U1Jv6/x8CzidiUCjtli
4T5IKJ9yWBIuMQMBdvasO+FLTyhFfkvu4FoPQkBdGPBEtZvLu+c35SBCXECbin70
09L99Fe9s0iJIsC1nOU1cKbzlczeCU25qnqkshcjPfMk0c3RAqDEYQUymWllg8en
pvAiwElvDoESatoQAa2z7y2FZ/LdNZTXk1+T4xVHTb5zGXOmTa2Cw2sV31pbXUI=
=dIaZ
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
