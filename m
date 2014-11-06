From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: toggle clocks on suspend if not disabled by
 runtime PM
Date: Thu, 6 Nov 2014 12:52:55 +0000
Message-ID: <20141106125255.GE8509@sirena.org.uk>
References: <1415272109-24970-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8WKGInOJRMBXYFEc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415272109-24970-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8WKGInOJRMBXYFEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 02:08:29PM +0300, Dmitry Eremin-Solenikov wrote:
> If PM_RUNTIME is enabled, it is easy to trigger the following backtrace
> on pxa2xx hosts:

Applied, thanks.

--8WKGInOJRMBXYFEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW28mAAoJECTWi3JdVIfQ8yEH/i+6hOISfZgAJ4nipNQXsBFJ
7QVb2BNLxi5aENYG77JZdsc1IvlZ0ypuq+/ny+h3JBs/XyNwxwc9Ob4BccM/2+25
WhzAsDNte0rdwWeC9PAfxzd4gny8b4jlLMLtn1ft0BOvt3ja8atWMBAuvYBMYLUX
a6JzNQcC4aa869h6zVDWbvEyuUsxmKb3A/mr9qaFfmPXc26FbQtVazZDDoiHBdTd
EAQSN9+rLfEr+RCdD3DpJ2RvBdyxoExIoI3cYy6x25httD+Eyaw1iDkxwAHQ3tDr
adpMvSGhArDg6Xj2oBPTpEmpcxmZZJoy+YtAzeEBZunX7xaGfL3Q3JdhDWY71fM=
=8ZPy
-----END PGP SIGNATURE-----

--8WKGInOJRMBXYFEc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
