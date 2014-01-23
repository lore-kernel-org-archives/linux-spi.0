From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 3/4] spi: dw: add support for gpio controlled chip
 select
Date: Thu, 23 Jan 2014 13:26:23 +0000
Message-ID: <20140123132623.GN17314@sirena.org.uk>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lJyeR2ag8/NQ+I8N"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lJyeR2ag8/NQ+I8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 03:05:58PM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

If you convert to the generic queue then there's generic support for
managing a GPIO based /CS if you set cs_gpio in the spi_device.  We
should extend that for GPIO descriptors too.

> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> +		if (ret)
> +			return ret;
> +		ret = gpio_direction_output(spi->cs_gpio,
> +				!(spi->mode & SPI_CS_HIGH));

devm_gpio_request_one().

--lJyeR2ag8/NQ+I8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4Rh8AAoJELSic+t+oim95jYP/jNjDnGlBFynu8oqOxyqO+R7
6+GP8g4A+dO8KtsweHJQc4A4+Xjlt3NZON5Cfm6ln2ba/B3YmfhVIb4qLgfJ8aGG
aIlqV3aEg9HvGr3CuRJu2wWQRVR8shOTzt5mwqtm/jXbwdKToBqEQlVh0XrIWWhL
Y5wZpNYKNXa/m+3cvGDMQq89qBZmb+ITGx56+uFzG67PVLeJRUYp51Cxt0RPX6tn
FC+4ACulqahBlz4RCWhemcdCITL+U5JHqnEujirZ0PEDoH5+4LDYW+62Jo1+w9s9
w949Os7ASC5A8qb4Qr1DtkS/CMsu3ACC+6scc/hJMyxCRzx9f+WZ+wsAywWEhGYV
4LVAKgv5dFoekW2THaQAAwspaRLltkujHm8rfxHYxnCr9X44Hq6OUER6L1oUPT7+
5OFoa0UQbumfUAwTgcaa1a6hx2ecw5xznA/0IQNR5bXc7ExvxQhYRghjlxMvGigl
J28QmP4DMHvCdWeywiGFz+uaqcDN8nD3a8H6MusVmJ8E7tZiJxFj8ZknG7UmcOM2
Dp/jbrNp/IXky24heVaGrWBpcK0/EF4UtFRJugHiLLNb3J5hmY8jlD14KXssLirj
Y6JyhZR0BqxLEQKRZ11Ro4ZuVeUgdmnyvSZU+KdXKn4bNhyN+rGeFPh0mOXj3pbS
Nk6yXfovTr0Abl2o8Mc5
=1R0/
-----END PGP SIGNATURE-----

--lJyeR2ag8/NQ+I8N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
