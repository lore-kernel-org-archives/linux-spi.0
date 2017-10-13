From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rockchip: Convert to late and early system PM
 callbacks
Date: Fri, 13 Oct 2017 11:17:19 +0100
Message-ID: <20171013101719.bophbiz7qb5wi7n2@sirena.co.uk>
References: <20171013100116.8271-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3u5jbv6mwl3adgl"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013100116.8271-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--u3u5jbv6mwl3adgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 06:01:15PM +0800, Jeffy Chen wrote:
> Currently we are suspending the spi master in it's ->suspend callback,
> which is racy as some other drivers may still want to transmit messages
> on the bus(e.g. spi based pwm backlight).

I'm missing patch 2/2.

--u3u5jbv6mwl3adgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlngkq8ACgkQJNaLcl1U
h9DyKAf8C8xs1BQHuO4TVTii4K0yYYHZsqWGyA1A+n5oAJb2fQbWFVdqW3bubAVW
vr9fjRwzoAoc9SL7xiHnxOdEvN0asEDyomGJlSKXdBSRswKLWJF8fiUuaLp2Yknx
mFS1V0nK/+ZJJwary6F02OHk9W9qHCkdy2HWV2V+2UH6LjfOyetUsfqhDrxnOZeM
N5joOjFvvuLhxhNpkQmx7FE3DSdGMqDVeskKL7l4jFW9eOIxmc+QDDUvoDvfpGiJ
0oU6RtYjnxr5CkWNALgchFfa2rpNrgH1Gz5M+8jRF9FfBNoqIO0sTcI1k82OkwbP
IcKhnEavkS9BdVUhW7mHXklw+6anWw==
=ni8X
-----END PGP SIGNATURE-----

--u3u5jbv6mwl3adgl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
