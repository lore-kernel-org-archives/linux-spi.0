From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 4/8] spi: rspi: Add support for 8-bit Data Register
 access
Date: Mon, 13 Jan 2014 12:29:12 +0000
Message-ID: <20140113122912.GT29039@sirena.org.uk>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
 <1389522464-1569-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JlQgkxKsF3TswZob"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389522464-1569-5-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JlQgkxKsF3TswZob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 11:27:40AM +0100, Geert Uytterhoeven wrote:

> +static void rspi_write_data(const struct rspi_data *rspi, u16 data)
> +{
> +	if (rspi->data_width == 8)
> +		rspi_write8(rspi, data, RSPI_SPDR);
> +	else /* 16 bit only */
> +		rspi_write16(rspi, data, RSPI_SPDR);
> +}

A switch statement is the more natural way of writing this.

> +static int rspi_parse_platform_data(struct rspi_data *rspi,
> +				    const struct rspi_plat_data *rspi_pd)
> +{
> +	if (rspi_pd && rspi_pd->data_width) {
> +		rspi->data_width = rspi_pd->data_width;
> +		switch (rspi_pd->data_width) {
> +		case 8:
> +			rspi->spdcr = SPDCR_SPLBYTE;
> +			break;
> +		case 16:
> +			rspi->spdcr = SPDCR_SPLWORD;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		/*
> +		 * Use legacy 16-bit width data access if a data_width value
> +		 * isn't defined in the platform data.
> +		 */
> +		rspi->data_width = 16;
> +		rspi->spdcr = 0;
> +	}

This looks very strange - if no platform data is specified the value set
for spdcr is one that can't be arrived at via platform data.  What's
going on here?  It'd seem more idiomatic to treat missing platform data
and a zero data_width identically too.

> +	ret = ops->parse_platform_data(rspi, rspi_pd);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "rspi invalid platform data.\n");
> +		goto error1;
> +	}

I'd move the error logging up into the parse function and have it say
what exactly is wrong - that'd be more friendly to users.

--JlQgkxKsF3TswZob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09wVAAoJELSic+t+oim9faEP/3KxOiawh1cklxsKzSF0mOg5
saloNBcyi/zPTsem/QSsqLooszVt0GrwGuM8nBpufTVixGUmPI6nKH1anPJtzbX9
AZss2s1q+OSrBbAmJJ+TqKlavM4XaLwKUStEGgatfGp/VHxra7en7tZOP/TeEI7C
dEQNRrRASvrS0O2hQ0EfHI/kW8mqk7A+dUn8uduMwffxledoRnajzW7jgIRVlEVW
Jh1eCrN67sas+3DszxeUZ/AhsqymZIbVbbd6zDHrONFvueDTCd6Ze8/K+jJQbJv4
z8c3HD+5pPm4QCYqugQz9n5CmZK3nepfHPAuZh+9CB3JcRrbqYIon1pNgTXSyqX+
va/6Lwy6BcbZ3yrRD/grgVBzKHVTfrKjq/mwBmXWdEbXN5Kmt5jPbwwp0aUDkfc3
qSoShpvnnJsSlMbrfwlvcBPY+JrppsV/yMAcv9mQZCXvu+ZlaugkTBSX/HQBLsBa
P1eboy/VwdpvaJ66Auvx8xMF6GyaRS2ndMbwtDAX5o1AGQPCDCvEBuC+BOrRJmY4
ypaYb6rYIuJ58jIaJUUHjqjHW1kfZ4yM4LfK93i3sZhkhLjDo0S4UPMb+3X+m456
Sl/sE/ZQPXvbezfjKRsrkzg1mPwp8waqL1JsZTp+T/YODWWL2+nG4L2u1LCs6Bmh
gA/q9y5qGyg9ytAhW+Ma
=bA2T
-----END PGP SIGNATURE-----

--JlQgkxKsF3TswZob--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
