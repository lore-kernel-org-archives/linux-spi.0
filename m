From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: Clean up non-DT paths
Date: Wed, 12 Mar 2014 16:57:12 +0000
Message-ID: <20140312165712.GW28112@sirena.org.uk>
References: <1394620523.3290.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X4KGi2zgEc2gUaQK"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394620523.3290.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--X4KGi2zgEc2gUaQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 06:35:23PM +0800, Axel Lin wrote:
> This is a DT-only driver, so remove all non-DT paths.
> of_gpio_named_count() may fail, thus also add checking it's return value.
> efm32_spi_probe_dt() never fails, make it return void.

Applied, thanks.

--X4KGi2zgEc2gUaQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIJHlAAoJELSic+t+oim9VWgP/1MzqpBjiNPKp2BTScplEvn6
OqZktfqr1Dlk1/7S5RdN33gGfKGF6/qyDZNeAPCJNpL3l5s/c79nRWc9V5HUN8L6
jco4jNoNqF8F8SqHGGY3wMa0hg2lwQ9obEZoBKh5jCkS2M2slwrdiCTsvbAt9/Qm
oeFfCn1pB/Qjn0e4nA37BmGa1yfBX+d/jMzmlvkSb5GxV7/IZxjeJQPXvOLBySS7
+Nbnhi6IF1fMcz4i3iJ8TcYb2IfX5bYI78A/4fi4Tm8TDOUduq+igido4DPldJYz
UhTM5gBgaDAxeu7EiuDLVFejKe51hglAQ0y5Nt2mX4OozEjwlei/U/ZVC2TyIcrG
hmLGyRU34mwFUC7tvnwPzSkoJx35gQ/1VGHNedXB/vXA/eU04hQqYTpOlrrlV69V
D6imTqpcbZ4CscWc6QiaDlzUax1r2bQD4+PQJ9KUZN+WPg6sa2WdIYQGK3lF4IXF
RQOdivWPW2NHan5B1ziQWBC+iKbheqv2O721u4+QrVpOM1N9h/KPOtleyqjuvac9
GWJ3gMsOhEcfpeAnN2OQw2ATcaC+KkpSTkjqw905M/N18hEBhEkvigAV8SBKZIUz
PE+2DXZPO25WjEDW+14ZKQSqefefCG1aj6kWqYbQ2iFHtMnoFFi45w0+Iy1dvj3g
CduqcKjHjwWAhZyc8zX8
=rtkw
-----END PGP SIGNATURE-----

--X4KGi2zgEc2gUaQK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
