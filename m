From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-imx: cleanup wait_for_completion handling
Date: Wed, 4 Feb 2015 20:53:26 +0000
Message-ID: <20150204205326.GL21293@sirena.org.uk>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
 <1422865837-10357-4-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AliU6hqk+0M/2vc/"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422865837-10357-4-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AliU6hqk+0M/2vc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 03:30:35AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int and
> always returns >=0 , this patch adds a suitable return variable and
> simplifies the return value checking as there is no < 0 case.

Applied, thanks.

--AliU6hqk+0M/2vc/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0obFAAoJECTWi3JdVIfQgOAH/1MSoXcNF0GpZDoSozARu1aJ
0hi7mtnAe+9Y3nOPxzlfmHoYHqwwuSucjCLX72hbnE/yiIyt9j3CwfHBLiCyOQIw
kNr8cia8QcHeUFs5F3Xet5WtyXvT0m3rmUUzaSMex//gMB1ZfmJUk4+oVjbzD2Ba
A2uGhKzOyzdVKg6CygiV1t/qJxiv9fQhuVemRQ0Q7WkYg0PTGlhgcbbUeQesZavq
WDugQmJkVC414YDJVqh1hQqGSkyUHtlc9G5/17dj8HLDtV8Zw0bYhT8h3pHB/w6F
MCttgFdRnmpzgIib4sS4wXEQtSk1ezrpx4QXsDPmS1wvHAdTyVi5DxtEgVxUmHY=
=pFdV
-----END PGP SIGNATURE-----

--AliU6hqk+0M/2vc/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
