From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use
	of of_register_spi_devices()
Date: Sat, 31 Oct 2009 10:03:56 +0100
Message-ID: <20091031090356.GA4722@pengutronix.de>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
	<20091031163259.5c651773.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8258220967048845384=="
Cc: =?iso-8859-15?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091031163259.5c651773.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org


--===============8258220967048845384==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> >  static struct of_platform_driver mpc52xx_psc_spi_of_driver =3D {
> >  	.owner =3D THIS_MODULE,
> > -	.name =3D "mpc52xx-psc-spi",
> > +	.name =3D DRIVER_NAME,
>=20
> You no longer need to set either owner or name in the of_platform driver,
> just in the included struct driver (as is done below), so you could just
> remove the above two lines.

Okay, thanks. Will drop it.

>=20
> >  	.match_table =3D mpc52xx_psc_spi_of_match,
> >  	.probe =3D mpc52xx_psc_spi_of_probe,
> >  	.remove =3D __exit_p(mpc52xx_psc_spi_of_remove),
> >  	.driver =3D {
> > -		.name =3D "mpc52xx-psc-spi",
> > +		.name =3D DRIVER_NAME,
> >  		.owner =3D THIS_MODULE,
> >  	},
> >  };
>=20
> I am hoping that we can remove the owner and name fields from struct
> of_platform_driver sometime.

Sounds good! :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrr/XsACgkQD27XaX1/VRvmywCdGQQdRHL8CIrS50ypAFOAJl7d
Mf4An3tRrAtngfopNf0r0NlA1aHqrfu5
=TgCu
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============8258220967048845384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============8258220967048845384==--
