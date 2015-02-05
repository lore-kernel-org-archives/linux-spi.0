From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: ti-qspi: cleanup wait_for_completion return
 handling
Date: Thu, 5 Feb 2015 18:04:36 +0000
Message-ID: <20150205180436.GC21293@sirena.org.uk>
References: <1423148622-3758-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EH95tw9Os8We5oNF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423148622-3758-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EH95tw9Os8We5oNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 10:03:42AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch uses the return value of wait_for_completion_timeout in the condition
> directly rather than assigning it to an incorrect type variable.

Applied, thanks.

--EH95tw9Os8We5oNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07CzAAoJECTWi3JdVIfQz3sH/A3ZBF3XeQyNIEFRB495H8o/
TP2ZtGpt8JP4fD/EF104IaoBO3k8iESm9nSrYptlTWkMWkI6/880TDcAvxygbi+/
j3djhlTWMn7E+TYRfb+SlzBU2KyDD5AHeFhLxNxj8Fz1poEzEAnJArWMLoLr1mRN
4MpHp0FPBMP3NI5Q6YYpucXulvTDkhw3TDMbaWyYot87EgYBSnZqjbgxh5cBNkXw
FSy27j84+jERu+bCGGdpLEikF7Z3a60jF7s5Fjglno2DVQooEdiSXwnd2IN07494
atTU7uTSVyhK567pb22arPROXuGS2iAybKLvqls3+lY/WVG7u5l216Zi03jEwR0=
=fTN7
-----END PGP SIGNATURE-----

--EH95tw9Os8We5oNF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
