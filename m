From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
Date: Wed, 29 Jul 2015 15:00:46 +0100
Message-ID: <20150729140046.GB11082@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Padmavathi Venna <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 12:19:57PM +0200, Michal Suchanek wrote:

Please use subject lines matching the style for the subsytsem so people
can spot that the patch is in some way relevant.

> The controller-data subnode has no compatible. This can lead to other
> drivers getting confused by it. Add a compatible to make devicetreee
> unambiguous.

I can't tell from this commit message what the issue you're trying to
fix is, sorry.  Nodes without compatible strings are entirely normal and
don't need compatible strings.  It sounds like a bug in whatever other
driver is becoming confused.

> +	if (!of_get_property(data_np, "compatible", NULL) ||
> +	    strcmp(of_get_property(data_np, "compatible", NULL),
> +		   "samsung,s3c-controller-data"))
> +		dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");

This will break all existing users which is not acceptable for
mainline, we need to preserve compatibility with existing device trees.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuNyNAAoJECTWi3JdVIfQncsH/0G7MS0/qfSwdPHn0o6yz8aR
q6xkpNSqE5FpL28c5k57qt8dHrL1yuXpXVYn6c0rqGwLYA92iuDEOoqM8Zs6y3IQ
9v26r0JcA2RBko7VYCB/OhVGCu+4adCy6kVhdHRulRoEsbhT126hO/b05vcf9/DK
HQT9omMnBttIVQvoQembTmMLnjepBasqL6N5CE00OQFcR/zNXrPNqmrC8JAAuAy1
jK9H/UgkrBrITvpvA6wgiy4+1797Z1ovgqT9YefUqn+nBHFhcvo29VV/wxrZDqnG
JHRT4qzJsMfav5GRZN7fhKw8rt+Mqsrw4aLP2SDLchzDUuoprW3MG80hHSHOQmA=
=RsyY
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
