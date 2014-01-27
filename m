From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: dw: document device tree binding
Date: Mon, 27 Jan 2014 19:08:39 +0000
Message-ID: <20140127190839.GN11841@sirena.org.uk>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <211f8d2101fff1790526f7dff766d0d9efff9280.1390723880.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <211f8d2101fff1790526f7dff766d0d9efff9280.1390723880.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 26, 2014 at 10:14:35AM +0200, Baruch Siach wrote:

> +Required properties:

> +- num-cs: see spi-bus.txt

Why is this mandatory, in the code it was optional?  One or the other
ought to be updated.

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5q6zAAoJELSic+t+oim9bCMP/3GmmlDzDemJVB50JLcWM2gc
H/KW31Cox3XFfIwHZ9Ug18QFHn44LSXABYcsrIvevhsGRIpKhmZDXxRehoVPVxrC
4SIz11pXVc5YBwvTXYnqPhYsTJgRJZ9oFFoXmTeCoCKcsqnufxajacGNJIVuewvq
tzWrvHi9uCxJu1KaLj3ITQUQ7uvq5y77f0O9UTzt9W/TYQXn4V9MIzVYs6JarS6k
o2lOSxFruCKRxmqgIH2l+4CqTn5hI50d+pLwdYf7xUybjsgMxaFoujWU9G733kWM
eiIr3hqWIWsf/zN/EAveHHMXGDRPMSosbw1ikRFIgjk56tdReR6FhgCB8F1a1pej
KcfEurPg85GKuZHNSvqZ2oUgQSs+kRHU6d34oUYQCV0fIjQGKzLtgVKvcMx1XV8n
8B0X8gy6GI+Qt/8nv+Dp34E7mKvVGBgtMrbQl6qvHrmhAgD9e5zMlPVaNIv+5u28
RYsRLeF9OS6BvW130+CHJ0Wm57HDf9rDBXeiTyinKG/6qEZ0BaLdXBwyM2NM7OOx
puiGNg+so7QSjpqIWKDNI4I9JaWEnEwluN47VXxLQEQBuJVdcIFnNz6mrPa2pKFO
CJVRs1iiH2VoMAqMiChQJcKdZjFqZa0TOTquKEmjno/KLdsKS5Oh6X4Z3xpXjvRc
rbMuOIPClB+8Y4xV7l5g
=pn6K
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
