From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Thu, 26 Feb 2009 10:58:25 +0100
Message-ID: <20090226095825.GA3058@pengutronix.de>
References: <20090220144126.GA9203@pengutronix.de>
	<49A264DE.8080805@teltonika.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4042892363136439781=="
Cc: Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>,
	linux-arm <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Paulius Zaleckas <paulius.zaleckas-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49A264DE.8080805-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============4042892363136439781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > @@ -1659,10 +1721,13 @@ static int __exit spi_imx_remove(struct platfor=
m_device *pdev)
> >  		return status;
> >  	}
> > =20
> > +	if (platform_info->exit)
> > +		platform_info->exit(pdev);
>=20
> platform_info can be NULL here if when declaring platform_device platform=
 data was not set.
> In this case you will get crash here.
> Should be if (platform_info && platform_info->exit)

Well, that is the first thing the probe function checks :) It will fail
if there is no platform_data.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmmZ8EACgkQD27XaX1/VRuMegCfXP5byjHDPVHfHfydTCSLyidE
LCgAnjzxXBUsBLH6+IToCj4qjFJrMSnq
=KF1P
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


--===============4042892363136439781==
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
--===============4042892363136439781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4042892363136439781==--
