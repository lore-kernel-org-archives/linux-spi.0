From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] mpc52xx_psc_spi: enlarge clock	range
Date: Thu, 17 Sep 2009 16:13:31 +0200
Message-ID: <20090917141331.GA3169@pengutronix.de>
References: <20090916204853.GA21627@pengutronix.de>
	<4AB241FA.9090604@toptica.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4449202263934450234=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4AB241FA.9090604-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============4449202263934450234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
> couldn't find any MPC5200 user manual on Freescale's webpage.

Hmm, it was the first hit using a web search engine :)

http://www.freescale.com/files/microcontrollers/doc/user_guide/MPC5200UM.pd=
f?WT_TYPE=3DUsers%20Guides&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_AS=
SET=3DDocumentation

> Is there a #define that I can use to distinguish between the two
> processor variants? Querying the PVR register is not a nice solution

I think you should have two different functions for calculation, one for 52=
00
and one for 5200B. During init query the device tree for 'fsl,mpc5200-psc-s=
pi'
or 'fsl,mpc5200b-psc-spi' and make the driver use the proper function.

(BTW I haven't checked for further differences between 5200 and 5200B; there
may be more)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqyRAsACgkQD27XaX1/VRuQnQCfbNK9MQn+0fWdhbq83XGhswFI
O4EAn34mzpcWELuI6+JEI8AOTJTe0W7q
=/3uW
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


--===============4449202263934450234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============4449202263934450234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4449202263934450234==--
