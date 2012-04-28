From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: rename config macro name
	for bfin5xx spi controller driver
Date: Sat, 28 Apr 2012 00:00:54 -0400
Message-ID: <201204280000.56056.vapier@gentoo.org>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120427172151.A00AF3E0B4D@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1123688184473927467=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20120427172151.A00AF3E0B4D@localhost>
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

--===============1123688184473927467==
Content-Type: multipart/signed;
  boundary="nextPart3936607.i4BGjAX8AG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3936607.i4BGjAX8AG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 27 April 2012 13:21:51 Grant Likely wrote:
> On Mon, 23 Apr 2012 18:18:08 -0400, Scott Jiang wrote:
> > This controller is only for blackfin 5xx soc, so rename it to BFIN5XX
> >=20
> > Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Is this series bug fixes that need to get into v3.4?

i think so ... i asked Scott to mark the ones that needed to be in 3.4, but=
 i=20
guess that msg got missed :/
=2Dmike

--nextPart3936607.i4BGjAX8AG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPm2t3AAoJEEFjO5/oN/WBHcUQALRTb+IR96bD+VvRRNRKy2lQ
LuyxE3ypbKuDmGw0ZO40kjbMnxp28LHkS7h8ULgMOHclofM5RnA3J9Mf3qpavoS0
+AEIBUHW6eFoEO4FNgCycU+TPYC8EqXF0AhTZqxLdZfy7gBhPZdcrnq4qopt7yGA
CHNrP0fQw4IqTPaa/TIIH03RarZCpQ6i2DfwHEBv6eOONOURbfCCTAO7x9t0JrbN
QzEgoaZOAEqJGopiZEnB8YCaaJzxjVONF2EwUAjX+b64nOxbOQe2gqOP+f5YldQ3
pw5hZkix8djgT3MKwgynl6jwDvScvgEloMiJDkzOggCKcOIad11gb+FQs6vebojH
rUZXaoIf82w5RYD4xnxaoeew+YXXWuhn1wWN6JKDnsHSPig4dERIbJl6WXZJ5Kem
TyIYYEGuH1XoqqYYzEqf9vUGQStLQ/PzK1/82lvEo7VL5TALCKTWvC45wHnjOrgF
1sXPfyagMcw9MGxLKLVnXwH8tl3qdvJkRPvYTwPSWrm0HNTJb8D9Gabp2uI4sHeZ
Sr+vHKs9VnUS6fEPuxJaD2qHE/CjoLnlU/LLu97l2Jj0GbCvW4cdE1gsq31dp6+q
pi2lOUPIeJv38FxyM//WRGRLWQ1F1bLJw47vJMl5sOAKm3p15Rcn3CUKQg/3RqU2
gFeUKObdV9xR1T8Tnmji
=xw8Q
-----END PGP SIGNATURE-----

--nextPart3936607.i4BGjAX8AG--

--===============1123688184473927467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============1123688184473927467==--
