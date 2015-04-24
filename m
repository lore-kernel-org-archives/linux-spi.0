From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: fix devm_ioremap_resource() error case
Date: Fri, 24 Apr 2015 13:38:26 +0100
Message-ID: <20150424123826.GP22845@sirena.org.uk>
References: <20150423121147.AFEA31A2439@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="477QOTsP+opw3g0q"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150423121147.AFEA31A2439-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--477QOTsP+opw3g0q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 02:11:47PM +0200, Christophe Leroy wrote:
> devm_ioremap_resource() doesn't return NULL but an ERR_PTR on error.

Applied, thanks.

--477QOTsP+opw3g0q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOjlCAAoJECTWi3JdVIfQ7fAH/iQdoHinfc/AEHeKe+LNKid4
pWTzbgxOl5ickly0B6s1KqERvcaSuU2nLqfk1m3P1WRw5MlUmM0ZkPZd9SWkP6jq
rqWxKsXMRuaItgbv7ftHFB3GeLVFDwm32LZjwj3ONKzoUmSZvNfFgCAU8ijgAVsy
+uPUCFMh+YgJMHQMCzffiuhhNdAgcZ1I9YUb48aO1E3wQdRkPizgcjgVXr3dPDmB
mG0HvboOe+xSwkJcg2k0BaxZuPwPfykDdQSEJUvR/0CibvUigZwe7/1wnBIJx+ei
O4tmPhGQPlIMlKODcPCOqz7HtURmw5HYNtqM7qFWIAcgIWNwfn9zNEZ6wG2bruI=
=gRmh
-----END PGP SIGNATURE-----

--477QOTsP+opw3g0q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
