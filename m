From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Date: Wed, 15 Jul 2015 09:40:19 +0200
Message-ID: <20150715074018.GD1426@pengutronix.de>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150714095442.GO11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150714095442.GO11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jul 14, 2015 at 10:54:42AM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2015 at 11:19:56AM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> >  static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
> > -	{ .compatible =3D "fsl,mpc5121-psc-spi", },
> > +	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_M=
PC5121 },
> > +	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_M=
PC5125 },
> >  	{},
>=20
> The code seems fine but this should update the binding document to
> include the new compatible string.
I don't find fsl,mpc5121-psc-spi documented either. The best I found is
ocumentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt which
describes fsl,mpc5121-psc-uart and fsl,mpc5121-psc.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
