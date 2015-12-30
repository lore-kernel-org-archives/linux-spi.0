From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: cadence: use to_platform_device()
Date: Wed, 30 Dec 2015 17:02:30 +0000
Message-ID: <20151230170230.GX16023@sirena.org.uk>
References: <CAAtXAHd_Xp4WbXMSY5QVLT7cYnpbzObf5UHCnuzh64LgOBER3Q@mail.gmail.com>
 <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OtXN0xDA1zr/oUEL"
Cc: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OtXN0xDA1zr/oUEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2015 at 10:57:35PM +0800, Geliang Tang wrote:
> Use to_platform_device() instead of open-coding it.

Please don't send new patches in reply to the middle of other serieses,
it gets confusing working out what the currently propose series is.
Send new patches as new patches.

--OtXN0xDA1zr/oUEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhA4mAAoJECTWi3JdVIfQHv4H/2LWbJ1xtdELbLM3fkhwKuFh
4wj5by5XnCdxYOgJN/5RuzSoFcUM7KyANK9TnOYKl3atSpJeq6knpcRLpVrm/hg9
YIn5AIsBNmX/dR4I4JCDq27mhGMfVEhhbBz5kpB7Jh4usVk6T3X+4DeMHaAlGsYd
nHX16B8VGQAO46Lr+1lWe1xm2BvxELgD0aO7o/BEVxrnjgpBr15eeZg8bGOcwTU8
1YSXI95kelMqGgX7+n+RRNCy1fCplW3khSINkorWEJT5s324jiBxhwXpP5QByTNO
VVYp6AAiwmrCCtz4Gvmgntn0DhMKWrhMcHFquJQNlzh+4zXNtKqth5F76lcYylM=
=TDGP
-----END PGP SIGNATURE-----

--OtXN0xDA1zr/oUEL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
