From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Wed, 3 Jun 2015 13:11:35 +0100
Message-ID: <20150603121135.GH14071@sirena.org.uk>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qkWs0iooC3sIAMHP"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433328587-20797-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qkWs0iooC3sIAMHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 01:49:45PM +0300, Jarkko Nikula wrote:

>  static bool is_lpss_ssp(const struct driver_data *drv_data)
>  {
> -	return drv_data->ssp_type =3D=3D LPSS_SSP;
> +	return drv_data->ssp_type =3D=3D LPSS_LPT_SSP ||
> +	       drv_data->ssp_type =3D=3D LPSS_BYT_SSP;
>  }

switch statement please, it helps scale new types.

> -	switch (drv_data->ssp_type) {
> -	case QUARK_X1000_SSP:
> +	if (is_quark_x1000_ssp(drv_data)) {
>  		tx_thres =3D TX_THRESH_QUARK_X1000_DFLT;
>  		tx_hi_thres =3D 0;
>  		rx_thres =3D RX_THRESH_QUARK_X1000_DFLT;
> -		break;
> -	case LPSS_SSP:
> +	} else if (is_lpss_ssp(drv_data)) {

Why are we moving away from a switch statement here?  Half the point of
using them for variant selection is that it makes it easier to adjust
the set of cases later.

> +	const struct acpi_device_id *id;
> +	int devid, type =3D SSP_UNDEFINED;

Don't mix initialisations with other variable declarations please.

>  	if (!ACPI_HANDLE(&pdev->dev) ||
>  	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
>  		return NULL;
> =20
> +	id =3D acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev=
);
> +	if (id)
> +		type =3D (int)id->driver_data;

It'd be a bit clearer if the error case was an else here, though - on
first read I'd expected to return an error if we couldn't identify the
device and the initialisation is far enough away to appear in a
different hunk.

--qkWs0iooC3sIAMHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbu73AAoJECTWi3JdVIfQnC4H/iGj0tn4maCSM5CpgYncf7oc
ORkVm1ClgD99yR1Nb2BO4zDoEFwzYWlMmpbzYhAbMsYrTDXV0jyICJ06RYW4XMCj
mOVGcdKCkvgKGlTPifDREfHgguxCNL6jhJ+51NPirlDbf870wdCzLltHY3ceWp9Q
jyvdKy2GM8Ln6/jivqZV9wK4sIIRcrz2ywzlUlQPu4lGItHZqJtJQ8CxLiRih5E3
agsz5prdYuhaJFkJDzeUXfASn5/6Psg1I2ItQ7zA1LTD3lFdBDpk5Q4N5BWJ/xJh
2wKLvm9irOkmtalq5Aiw6e6Kasi2KGRy5cauozJ11ux2giD1VOXqrgwMimW63eM=
=oJBF
-----END PGP SIGNATURE-----

--qkWs0iooC3sIAMHP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
