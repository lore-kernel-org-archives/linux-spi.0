From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 18:40:03 +0100
Message-ID: <20150407174003.GN6023@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
 <551A1185.6060502@wwwdotorg.org>
 <20150331052519.GZ2869@sirena.org.uk>
 <552094B5.3050109@wwwdotorg.org>
 <20150406172130.GU6023@sirena.org.uk>
 <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
 <5523FA17.6040009@wwwdotorg.org>
 <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qj6EhVtbuE7iUtz+"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qj6EhVtbuE7iUtz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 07:05:01PM +0200, Martin Sperl wrote:

> But as spi_messages with multiple spi_transfers are rarely used
> and as the issue itself is only happening only with a low probability
> and some devices not detecting cs changes that are below a certain time
> the likleyhood of such a situation being detected are minimal and
> would typically get attributed to other factors...

For your workload perhaps.  For some workloads they are very common
(register reads are the most obvious example, they are typically a write
transfer to provide the register address followed by a read transfer for
the data).

--qj6EhVtbuE7iUtz+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJBZyAAoJECTWi3JdVIfQk0gH/04U7MVZRXPk6zH91lzXsq4h
XXhp7z10lOfEyxXxQjUIRN6IgCq683fP2MGvjU15UiVobSupUMneHnlsh4z2mz5h
XbB972WJNeuH7f+FXxGix1hS8wD3vZ9JOoyZkIRC8LILIzyOhwQpyPd8GoHJtvzv
GnZabar/NGxchqJS1zxDRD9Qr/Af4QGp9GJPG1ZX42OC/QTK95XX1wf5oXMvq4CF
MXN6bvpTUYElLk6sij1Qp6jDwwMu5r1xzmdK8akEX58yQvs9XHJeB+pFPBqQI0WH
wd8DbLQ50xiPVG6+Lt7WJEiiewCqajFyLEq0XHkBsqFihbVFfMgbeSX68qyQFe8=
=jhcO
-----END PGP SIGNATURE-----

--qj6EhVtbuE7iUtz+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
