From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Date: Tue, 14 Jul 2015 10:54:42 +0100
Message-ID: <20150714095442.GO11162@sirena.org.uk>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NRJnUXaAQEpDRr3z"
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436865596-9592-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NRJnUXaAQEpDRr3z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 11:19:56AM +0200, Uwe Kleine-K=F6nig wrote:

>  static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
> -	{ .compatible =3D "fsl,mpc5121-psc-spi", },
> +	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_MPC5121=
 },
> +	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_MPC5125=
 },
>  	{},

The code seems fine but this should update the binding document to
include the new compatible string.

--NRJnUXaAQEpDRr3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpNxhAAoJECTWi3JdVIfQQ+oH/0seBIzXzOt9A+Sap/VyF8pm
vqXxrsMwBRoqmTuT+VOu4+WvPI2bQ6ZlmecEyZf4yLWwPfBe/4g3H6mR2Vok2sGQ
wvvBk9M9VkLlAURjG8AWQ+xERvN1JKMzzHwNmYdVuoLkE7PfMeAQTXpyVQrBjxAZ
TTeKiiGH2jVoX37LucUTNVTltkX4kUJ5Cfuq/yRF7AgPtPE5HX3mdaA248VdXL0N
RfvQSHKV9PYMiRXIZcKEXnAtbcfvjWVQqsnEaiHEIveGGOeMCHiGebij8SXM+YRP
l8G8KXxCLBv7UC8EC4BfnEXPDu9EfbMZtGIhksAhOHHFKEm+KVeUlkTWZUp/sgA=
=S+rD
-----END PGP SIGNATURE-----

--NRJnUXaAQEpDRr3z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
