From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/spi-xilinx:  Add clock support
Date: Wed, 9 Mar 2016 09:42:00 +0700
Message-ID: <20160309024200.GD3898@sirena.org.uk>
References: <1457426528-15247-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457426528-15247-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2016 at 02:12:08PM +0530, Shubhrajyoti Datta wrote:

> +	xspi->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(xspi->clk)) {
> +		dev_err(&pdev->dev, "input clock not found.\n");
> +		return PTR_ERR(xspi->clk);
> +	}

This changes the DT binding but does not update the binding document.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3412AAoJECTWi3JdVIfQ/PIH/26FGHuAIEHfGu/Y8jDLKqoJ
lwF3q8zf3Dauns/kXD8+pxvBVDC2dme/cUvcoT4YbMfLxUuXHUWygm84qmeBuaRV
NpJtzU21OTNC8zStuUANok2wBvvvCR2tAa/1wv5OKCFhULAFfmOsJo2mL+HI+gB5
2JeZwOgAUxSWy/OKRwGnk7JbfwcH1Ea+aHPMAEsJDgQh1Ylk9xJ+rpsnCcpXaXLJ
w60FnDMtOQ9PxNwzqu8r0Ur1CnPgBAQe+suhMLO6IJZRH524XXttTHwveX5NHnGL
GZTSWJSWF/AuwYFEL7Lle8iourRhY2/4O/uJvnezQzq+ghmosx1eaBRbkgg0HKs=
=r11p
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
