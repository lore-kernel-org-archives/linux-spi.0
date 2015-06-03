From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Wed, 3 Jun 2015 15:39:09 +0100
Message-ID: <20150603143909.GM14071@sirena.org.uk>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150603121135.GH14071@sirena.org.uk>
 <556F0A34.9010506@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cs2w6Z3FJD+b2LjO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <556F0A34.9010506-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cs2w6Z3FJD+b2LjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 05:07:48PM +0300, Jarkko Nikula wrote:
> On 06/03/2015 03:11 PM, Mark Brown wrote:

> My idea to detect these newer platforms and set the type accordingly is to
> check does the device have named resource "lpss_priv" in a code snip below

> @@ -1299,6 +1319,13 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device
> *pdev)
>  	if (IS_ERR(ssp->mmio_base))
>  		return NULL;
>=20
> +	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv")) {
> +		type =3D LPSS_SPT_SSP;
> +		pdata->tx_param =3D pdev->dev.parent;
> +		pdata->rx_param =3D pdev->dev.parent;
> +		pdata->dma_filter =3D pxa2xx_spi_idma_filter;
> +	}
> +

Why not just pass some platform data?  The above seems like it's abusing
the API a bit and might upset generic code.

>  	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	ssp->irq =3D platform_get_irq(pdev, 0);
>  	ssp->type =3D type;

> That made me thinking can I set the type to LPSS_SPT_SSP and needed DMA
> filter directly when acpi_match_device() returns NULL. At quick look it
> seems no any other platform device case than our new MFD registration ent=
ers
> here but have to look at more carefully.

That might work too, checking for DT as well would help defensiveness
though you'd have to watch out for board file registraitons too since
I'm not sure all the PXA platforms were DTified.  Or just register the
device with a different ID and use that?

--cs2w6Z3FJD+b2LjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbxGNAAoJECTWi3JdVIfQwpYH/0veHjNfibKVRdnLb4evb6g0
/Ir/ljTkY/5SpPMAxaQ7SSEhPyGy/pYqRKqNmpljgsffEPmVN4HlRAeVG6DyBa9l
UPtd7MdpXZ7BLX1HvgX2FM8kKkiL5ksaaKVQsmtPMDE9uZiqZrQvVlq/tm6EIZGn
w0/p0H/XUJHK5gPViP4C9Dh+7wpOVVK1Flpff8JJ09CWcO/tWeJoKvH7m12MafC/
ouDWr+eIdr2n29GAmNwVWkuDokyYpi79wC9O1t51DHKXs7tR+J4IbTeHL41kzazg
sDJeFCBQ/+0zd1DFGI0tAT0Y/pGtEA+ZZlEVqBjgnqehhyRbqcFJ4u5EnkBPnWc=
=DxiD
-----END PGP SIGNATURE-----

--cs2w6Z3FJD+b2LjO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
