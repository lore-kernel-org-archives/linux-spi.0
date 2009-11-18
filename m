From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] spi/mpc52xx-spi: cleanups
Date: Wed, 18 Nov 2009 10:58:28 +0100
Message-ID: <20091118095828.GA5166@pengutronix.de>
References: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
	<20091117144300.GB4850@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5653467884356799333=="
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091117144300.GB4850@pengutronix.de>
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


--===============5653467884356799333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
> > +		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, 0,
> >  				  "mpc5200-spi-spiF", ms);
>=20
> The "spiF" here is probably also a typo.

Ack. Grant, if you think it is worth you may modify my patch to avoid a res=
end.
If it is easier for you, I will do the resend, of course.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksDxUQACgkQD27XaX1/VRsTigCgrkUG9+1oz/8cC7ECpaKl9Rny
6HQAniy4zbAJVxqn2tyQSTUAu52NWnJt
=YdQy
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============5653467884356799333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============5653467884356799333==--
