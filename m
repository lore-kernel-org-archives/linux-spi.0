From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH V2] generic SPI driver for all
	i.MX-platforms
Date: Fri, 27 Feb 2009 11:39:46 +0100
Message-ID: <20090227103946.GD3481@pengutronix.de>
References: <1235665315-2792-1-git-send-email-w.sang@pengutronix.de>
	<20090226163721.GD3058@pengutronix.de> <49A78AF3.1000606@tqs.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0809434445157353268=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>,
	a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Jens Gehrlein <sew_s-77yLcl8UjJQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49A78AF3.1000606-77yLcl8UjJQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============0809434445157353268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Do I understand it right: the driver has a bug, not the CPU?

Well, CPOL=3D0 means zero based polarity, no? The refman states for POL:
"0 =3D Active high polarity (0idle)". Now, look at the FSL-driver:

if (!(spi->mode & SPI_CPOL))
	ctrl_reg |=3D
	    spi_ver_def->mode_mask << spi_ver_def->
	    low_pol_shift;

Looks to me that the '!' is mixing things up here. This is why SPI
devices from the FSL-BSP usually have SPI_MODE_2, although SPI_MODE_0 is
the common thing.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmnwvIACgkQD27XaX1/VRsUYwCfWPj4RoiuirghKrBiyPLBcvWG
OpYAmwVHUPFIDnf3xu+YF3ESNJXe34+b
=S3G8
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--


--===============0809434445157353268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
--===============0809434445157353268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0809434445157353268==--
