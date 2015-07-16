From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Date: Thu, 16 Jul 2015 14:32:59 +0100
Message-ID: <20150716133259.GI4039@sirena.org.uk>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150714095442.GO11162@sirena.org.uk>
 <20150715074018.GD1426@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150715074018.GD1426-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2015 at 09:40:19AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Jul 14, 2015 at 10:54:42AM +0100, Mark Brown wrote:

> > >  static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
> > > -	{ .compatible =3D "fsl,mpc5121-psc-spi", },
> > > +	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_MPC=
5121 },
> > > +	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_MPC=
5125 },
> > >  	{},

> > The code seems fine but this should update the binding document to
> > include the new compatible string.

> I don't find fsl,mpc5121-psc-spi documented either. The best I found is
> ocumentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt which
> describes fsl,mpc5121-psc-uart and fsl,mpc5121-psc.

OK, then please add a basic binding document.  The point is that new
bindings should be being documented, if people have been lax on this in
the past that does involve a bit of cleanup.

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp7KKAAoJECTWi3JdVIfQsDMH/iMvzcRjDtq+CnoSEV4F81Gn
jAGVtfP1xIYXNFzslzb6v2GfzgPAso4XXh8zUdtPi52ECTCW8ezXyyOHqhrEngCh
4VmOySSEAXHQbZA4keZ2eztIFC3Akv9IaFbhf8WmzPI6wL8X7IXXwxSvtka/bTjI
h5Exya3UAPz11ZsD6XQsxPnQxQkc1w30z2gFcNCKWgb6MgDnCxvr8BLdLWdjruwj
mKUDiu2idvj3qOE3EdTTRQiCArxZzrST8c2aLoH2s+kAqUz2Hh71y4sDwgmEU6BZ
PsW39Lg8XByY7TKT5igVEPKcayO+QAZ/aGZBt0xJ86R4XTBgJ/Kbrsgbi+Paffg=
=Jxih
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
