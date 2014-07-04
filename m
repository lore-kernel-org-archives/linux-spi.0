From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: au1550: Fix bug in deallocation of memory
Date: Fri, 4 Jul 2014 19:33:54 +0100
Message-ID: <20140704183354.GD14896@sirena.org.uk>
References: <20140704173949.GA8558@himangi-Dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org,
	julia.lawall-L2FTfq7BK8M@public.gmane.org
To: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140704173949.GA8558@himangi-Dell>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2014 at 11:09:49PM +0530, Himangi Saraogi wrote:
> This patch fixes a bug on the deallocation of memory allocated using
> request_mem_region, by using release_mem_region instead of
> release_resource and kfree.

Applied, thanks.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtvOOAAoJELSic+t+oim9N54P/A3Aikg88DzPX/XkNWWhxxPw
yLnMbfEBZgsFvoJTRcB+1QP4qvzSYEq/TEVI3N8UCzcz70l8aAOgfYzms6yqqeJh
5HWjCBh6HOzXFhVmoULo+pSy2/K8VBoA78gnDTpoAuTSQRrqn8rBnXZfVuvv0uL1
KGwRkg78SclmInMoRPK+1efiNPH1EuB5AW/dpfg4mFvLWy8LB4HXL2Z7bGjf8sO8
tZVpv7Xd71twhzUnm256jdiWlvcoAqXUHYy3U+lXxaV9lzueXaJ5sl1tF+7xg6V5
ETs4RvUVpHlQmFL0Th3rDhWf4lLrkCbvOgj92ZFZz4aAeDONuY5iG4mKqEBzMx1P
1WWOG0Iw23EHvZeIMw91iNGTH97J+mnzgyZm9hbi0N/NzsSovAMMMx9syU5vkwvL
od5AlpXJPeXQ7UNUg7qKs7XB2mwiJepECh+yOhuh8Hju+4ZLdYFZo0h4/8+Tv35n
hUutioKQKN69swxh14SJHYOge8PXmtn84L9JdS9qw8ZQJ8IcjNuitUJHqqlwJBKt
LNdZD6UVL34Un1xlkXH2a9oULcoDoSCmMk/138xzs3Jt2jSBIel7dAModHU9qOGn
fhewcyf5ew65I6lm2o/ehdzIhpoAjA4l7xsO4Ut0/JCZAkP/H85Cmuw8Uwx+Fvs7
OxFGsNhRVIpdlZm/6e2d
=0Umo
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
