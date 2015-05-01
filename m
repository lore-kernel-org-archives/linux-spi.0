From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: sh-msiof: Constify platform_device_id
Date: Fri, 1 May 2015 17:41:57 +0100
Message-ID: <20150501164157.GK22845@sirena.org.uk>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495047-31122-4-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y+Fz16W+AXV+aTRW"
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430495047-31122-4-git-send-email-k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y+Fz16W+AXV+aTRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 12:44:07AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--y+Fz16W+AXV+aTRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6zUAAoJECTWi3JdVIfQHXMH/jHU8hRaOR7DUlJlWqeKLo2P
HPxhaIPaSVFnrNsYhemwCHamrDj6MlCyUyfIZtwmUKEfAQ9P0eSGX9DG0E4kOabC
RAAcvxV3d9pAdK8O0lFLS37BFs63Faa8pebUGkSOIxDm2m1j8FRRBbpqkWJFwgaF
EYN7LzYq+2gHFPhGY5iYbexcndavli0asWu8NfR8HB1naioIVaxz2X8iLKNj1n6p
pBvZRpkSqTQKR7+mPRAefbbj4qK3fFA3jjcD6zyYbvw+dHf/REo79v6SWzc72ZyG
XpzTBnST/rITYv0JDA3Ne1RmUuzY8VSPbY9YpNPYZZ9mWN9lR3soDbYOaUquNGQ=
=pdny
-----END PGP SIGNATURE-----

--y+Fz16W+AXV+aTRW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
