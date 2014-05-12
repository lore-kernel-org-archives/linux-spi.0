From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Remove unused dw_spi_cleanup function
Date: Mon, 12 May 2014 22:04:38 +0100
Message-ID: <20140512210438.GS12304@sirena.org.uk>
References: <1399547827.1783.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4tde/aUCtLj2gjZL"
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399547827.1783.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4tde/aUCtLj2gjZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 07:17:07PM +0800, Axel Lin wrote:
> The dw_spi_cleanup() function was removed by commit c63f5da00845
> "spi: dw: Don't call kfree for memory allocated by devm_kzalloc".

Applied, thanks.

--4tde/aUCtLj2gjZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTdjAAoJELSic+t+oim9a44P/jHpsyeXmmQSphm1CG/r68sT
s531jNXoXqVo+D2B49ogL++bMFU3Su0PTuekq8UcABeEOqj0AxzMmwv4ZyrUDeQY
uxin9NI3NQoXjbJWgrqcSxeEykiBfPUdKwEOw3+SKqBZLZHR+0fOLXxD0VvCz73S
zw/OVyXywbt/YbGD+RWUWWIiszeOdUVKosMaClV6tbyoiPmPtw31ysu44fLsJPvi
zjO1SRupCCkXEvEqPSN5sK3Lkv7bZ6ssPNKOZmzNqSTWtncRBsiOR8rX7RITF8/u
Y0xXy0vFjpaahLrPRJ5xn9C6s/EmDaZrHoWJsgUy1ua75bnnVD0gvN4dPQjwxmoH
G08QXL4qBzORQ0652I4wKfM4PRCTMF1MA+Lym3CYUG3uAYgr/UOrSj2AYbyMPqsU
Z7QkjcGs5oowQbLoQtQoFl7NFBnjIKOwnMvA5YfqXx2ZZpNYiQxKhEmguoS1dBih
CRewfkCv47PFkLM1JmIT0xNDB4htdzxObsJH1jFNt5O42KrbHKv3QzKL4E3siP2F
bh2F6LlgSj3VaST4hUWe5biNzi5kjbT1S2XeES7D3ZQGq2zwlP5FnV3BM0CPKUns
AJf9JZfPPQp8iYCMR0WRhTfv21myrGVCTQreVcmym8KkK4Va4ymk6CQlJsyZEO9G
L5ue3GvKDTZGkAepHKxp
=hYHs
-----END PGP SIGNATURE-----

--4tde/aUCtLj2gjZL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
