From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: Update binding document to make
 "efm32,location" property optional
Date: Mon, 7 Apr 2014 10:56:59 +0100
Message-ID: <20140407095659.GB14763@sirena.org.uk>
References: <1396854706.27810.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qrXwk4mdkt00hRU3"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396854706.27810.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qrXwk4mdkt00hRU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2014 at 03:11:46PM +0800, Axel Lin wrote:
> If "efm32,location" property is not provided, keeping what is already
> configured in the hardware, so its either the reset default 0 or whatever
> the bootloader did.

Applied, thanks.

--qrXwk4mdkt00hRU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTQnZoAAoJELSic+t+oim9bE0P9AslMAwEng3C3b8IsaxJRXme
IFHMZqG0XQyZ61OU1AgR2y82G2e/r04MVuUN1DI/MFFkZn/y5uNg+gtnaj/Achg4
ujpKwxzvT2iV57LSdrKUkOHdEgP9COi2+GPuFCexOUGmQ0NlbH4zHSPdwQhCrP58
9kSHQQ8usopxBpx2UH+N0l9Y9sADFa4Y5KDpao0rVuJSxMPCmXJOlWd5Bc1xg3bj
3PnQutIzuasWN+7tYYbCx+eUF5kPaAF/n0wGduQBepEvOTLL15yFUqeFMxfrzWbq
O8QTis8CyJDKIxpU3K7rVly070Xk6+tjVogmGuv+1tM1o72usJ1hhzim7rQ02OYd
SOboWONJYI4NBQBSvszkPUTZS+k1z9778ZVTtM6ojpxj6khzOIfEl0HDsMc0kBN4
WzKxE9Hz2FDVmGGCe1F8GjPzXB6fjY1PkIaTLf7z7NRSw7cE4SewTt1ydAoPjLUZ
WSZUah215uKIavIIW8BTY+42pQhGmNH7Tj7MJbK7yYGiHYQmG0JB/Jz7apvqxzEs
QwJZL5WYrBprC2WQN3j5wk/g5xQCi5AitVhLxgcAK7TGxkQUlPHqgJALGdlA6QAr
hZPhfE9rpp7WGSFw6HwIKXgsVycBMh21MUvXT5yQkptwzpko1DGQL5QCjhvySM+E
8O796SHWhc4Ruy/2Pdw=
=au4z
-----END PGP SIGNATURE-----

--qrXwk4mdkt00hRU3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
