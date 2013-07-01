From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH v3] spi: add spi controller v3
	master driver for Blackfin
Date: Mon, 1 Jul 2013 11:41:18 +0100
Message-ID: <20130701104118.GG27646@sirena.org.uk>
References: <1372284460-3827-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4406349429799375024=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1372284460-3827-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============4406349429799375024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eVUvLhJy3aWqIBaz"
Content-Disposition: inline


--eVUvLhJy3aWqIBaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 06:07:40PM -0400, Scott Jiang wrote:
> New spi controller(version 3) is integrated into Blackfin
> 60x processor. Comparing to bf5xx spi controller, we support
> 32 bits word size and independent receive and transmit DMA
> channels now. Also mode 0 and 2 (CPHA = 0) can get fully
> supported becasue cs line may be controlled by the software.

Applied, thanks.

--eVUvLhJy3aWqIBaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0VzLAAoJELSic+t+oim9DTYP/0mKKj9w1LRk0Z2y5/dFXv3B
Orh9Aa8BqXgyf/dKPfRqvFFAZPP57IevJlFMzUiK6WAuuZ359xkQLJzba5CwnSKT
SvEmRgiIPsPjRyJFAZ2Us/qVaPFNCsjRPCMa4NTYOZqGCLUK3o3PRZxNCSP3gofl
L9OnMX0md28l63SjacGa3zBFdvEsB2WBDZHRa/r5xF+RlwYPetofFVciwyet7wIW
6gdlNegycPpGMJ0/Kou/jfWF43IhourpVOUatNc7h4/pNLM8NwfpehzOTlZ/QzI3
VhhRoOX/oE7cmospmqBCAI2b3UjcGAScTFatwRR37m5wjVSaRwC3kHzcGwsAbHBv
9xNLl/++rC1AShenegd8Ljrw1D4qb2hprS7E0AFQmLdsWEtSmUtnCqOgG25X2yr2
zxzoULd3dJccN+2VvJnfd6XPk3tYiuvf2iKM6xOPMoW9OjnVKt/3HJZb3OupHaIN
jXEJDpAYEWnMxXbLum7Sks8liZnFKzD2ROFNdrA7tJCfNDloAcnvxNuKkyljqdp4
lCYIhK9TYJUHOv/fdnrvmkJ7IAXRe+TcrzWpvdiLusYvbaTWkWRMtBqKVSt/XI27
gwd095kolxYsw69887l8k3Qju3+TUv3/RlSERY/+Jwey3o67+i8ZQ1t9UNiWlCtT
v6P9aLqvlLVZOY7FugQG
=Dx+y
-----END PGP SIGNATURE-----

--eVUvLhJy3aWqIBaz--

--===============4406349429799375024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============4406349429799375024==--
