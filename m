From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dt-binding: clarify gpio chipselect language
Date: Mon, 9 Dec 2013 18:01:48 +0000
Message-ID: <20131209180148.GP29268@sirena.org.uk>
References: <542dfeee809e73f7f071f4ae0b4f95af7736f70b.1386243545.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UWzACjsgnYjrQHZk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <542dfeee809e73f7f071f4ae0b4f95af7736f70b.1386243545.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UWzACjsgnYjrQHZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 01:39:05PM +0200, Baruch Siach wrote:
> Commit 743179849015 (of_spi: add generic binding support to specify cs gpio)
> introduced generic binding for gpio chip-select. The cs_gpio struct field,
> however, is an internal implementation detail of the Linux SPI subsystem, and
> should not be mentioned in the device tree binding documentation. Mention the
> previously defined cs-gpios master node property instead.

Applied, thanks.

--UWzACjsgnYjrQHZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpgWJAAoJELSic+t+oim9/+wP+gLcD4f2+f6D1a3//iIYXYxa
tyVAcFcZNTnfiHMkneI9sZyqRqhrKwzFuMAFulIJJYVgoFnverWn7Pd+0gw2kCmL
+dEBfIZ/9BKcBMbugX9pom0WhWuxhsa+t26/Ns8+j6pkrIgcE/H7mxgN6igGbsq1
8pEbrLWJp6Xsmysg5D0klQ4pRNbPGH9hlm2vC2kFkxtbp/e8tjpcjP3LeyU1no7B
qk59pZuYZm3I52C5ktANqBuU7Ne3iHy0YZw7MtERvH03teemxrKBcFfVFZK5m5QY
eQeGr2nlle1jbGY/303Hbmt2Zo0PXimC3WFmlsEMWB0GfIbbub6lCuvp2m+jL4Dy
oghUI2vfrS1KhpkbvrhbL/2LpDC58wHBYcXVqoqZT3P6ILVGukMwfVc4dzC6uUWn
lWmq2sT+nc8L5xcBa7gwri0KWeIssK+xIaV5oxpOrcngwnzJlYXgJ3Nw32VkZqPH
M6ZtNO3mhNJeQg7x9lXjd1n/b9h7f4SkEgqkKsa/qAs0BVcGLTu7k++581WT/yjH
HIcbLMURBDv8BRJsCeFXysM+2LFGz9iRp/9O8czLNkvxJ10uBsxHsje2WDTCn0er
tliRKK9CtNEC02on+TKnMhG6dYjvzKbfMMVcZYPQrH6D92AxVBjSwqDx6+XsbVrF
TDHUadcudHomQak87J9D
=NhSo
-----END PGP SIGNATURE-----

--UWzACjsgnYjrQHZk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
