From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: altera: Add empty implementation of
 setup_transfer callback
Date: Thu, 9 Apr 2015 17:10:59 +0100
Message-ID: <20150409161059.GA6023@sirena.org.uk>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
 <1428591822-24279-2-git-send-email-per.nilsson@xelmo.com>
 <20150409154045.GZ6023@sirena.org.uk>
 <55269FDC.8040306@xelmo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MDU+/juvgb4cyX6k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55269FDC.8040306-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MDU+/juvgb4cyX6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 05:50:52PM +0200, Pelle Nilsson wrote:
> On 2015-04-09 17:40, Mark Brown wrote:
> > Why is the callback mandatory if an empty implementation is OK?

> Ask the author of spi-bitbang. :-)

What I'm trying to suggest is that you're perhaps fixing the wrong
problem - make the callback optional if there's a good reason for it.
Why is this patch the best fix?

--MDU+/juvgb4cyX6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJqSSAAoJECTWi3JdVIfQorAIAINBWRKEB/ixDnOrO2FyZbO/
GRSCnzgin9MxASSHvnGZL4/24nQUYZSRrFbIrXCGXeyzxg/MFcEtL2ogJBXfIDhS
tvo7lRX2N0zmpp+OX80iceQ7TeL5OYkrcTLCp0YquN75XCmZHat9UaloA8lxGINR
GKjAxgQn0OcFI3usILKvCqZ/2ufrb7abRc/AJR1SIn894j6I2KKiZxLX8f5jeyZw
97buap6uXOmVwzGyGRIuNsif+314bObWfnGdVs12vvY9gn6yK8wwCS6LwNsHI+ik
GpUdTuncdRs4Dxp1sVTG0iWbCmZGKdywgnreOcjIxpWGtXQFXCVugGlrbyTASUE=
=Cj4k
-----END PGP SIGNATURE-----

--MDU+/juvgb4cyX6k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
