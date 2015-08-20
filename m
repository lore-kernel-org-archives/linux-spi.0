From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] spi: mediatek: revise coding style
Date: Thu, 20 Aug 2015 11:17:52 -0700
Message-ID: <20150820181752.GH12027@sirena.org.uk>
References: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
 <1440062349-25513-5-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440062349-25513-5-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 05:19:09PM +0800, Leilk Liu wrote:
> This patch revises littery coding style according to comments.

I can't understand this commit log, sorry - what are the comments that
are being addressed?

> -	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
> -	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
> -	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> -	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
> +	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
> +	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
> +	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> +	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);

This isn't a coding style change this is (I think) renaming a bunch of
variables for some reason.

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1hnPAAoJECTWi3JdVIfQWHcH/A2n4Ej3jYZ0ewdd4kjaiqoD
xh6Wa5FqJEMDr+R/kJJtwQs2tb9Ch5j15P/xYQGeYiyhOqX5HiePrYpV4Vvn5j7n
hS8LlJkaj5EgB6CKqQ2diN6+tcf/61mjF+tiU+BoWyJA6HN0SjHNQOtvYmolvawI
Iim2vtjIW7UtUq/3r7V8zidi0f5HEb9xZCBrbUmq0adrJmxOLKmhEo8F4ONwWOGk
77vwGgMeTpYAQGBpMKb3ga6BmcdLf+UzVDilHcr6xFXWhcEF+xcpvM6UR0WyxHJ+
peECbSrsTLHnOTehnapOh8esDShgABz66YuqF14/CsMrpMtSooTnJZXgTNRs38E=
=HL3K
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
