From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 01/10] spi: dw: explicitly free IRQ handler in
 dw_spi_remove_host()
Date: Mon, 19 Oct 2015 20:29:54 +0100
Message-ID: <20151019192954.GS32054@sirena.org.uk>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1444853545-59868-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/KohU7xR/z4Rz7fl"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444853545-59868-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/KohU7xR/z4Rz7fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 11:12:16PM +0300, Andy Shevchenko wrote:
> The following warning occurs when DW SPI is compiled as module and it's a PCI
> device. On removal stage pcibios_free_irq() called earlier than free_irq() due
> to the latter is called at managed resources free strage.

Seems better to just convert to request_irq()?

--/KohU7xR/z4Rz7fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJUSxAAoJECTWi3JdVIfQGf8H/3qROpnIm5zcixvXN8rWLhsr
vlt3X7CNfFUviFzP7BGoHH0nmdm4h4lspyMboeYqhOtUNLJxU/SRs1PjsjNklntH
3k6qt9e/g4ypTXHrp7f/PQ3pVM3+0p6CCb1rbsAVVm1hLNQtQ5zQkE9XGfCBZofY
0CIHH2vNK5ahupfw37olCIGV8bOsF4lV027Bt48VgWzMcvLwp7OdrqQZ/Ft7Hz0s
djYcHdwftCkHiXyT1YD4MiUlUuvvV5wmEmUAAf/7kvoCPrcd18yzs9oBG/q2YoNS
OjYFrR9IKgWvfsXg+BjaIGvgeWXX+RfCUky3A0NVV1vUu/afwHGnjqWSI0kcAyw=
=G60g
-----END PGP SIGNATURE-----

--/KohU7xR/z4Rz7fl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
