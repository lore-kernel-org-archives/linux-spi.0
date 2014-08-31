From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/drivers: Restrict COMPILE_TEST by HAS_DMA where
 needed
Date: Sun, 31 Aug 2014 14:00:05 +0100
Message-ID: <20140831130005.GG29327@sirena.org.uk>
References: <1409328631-1420-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mOKeRhn3B7HglGBY"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409328631-1420-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 29, 2014 at 06:10:31PM +0200, Geert Uytterhoeven wrote:
> commit dd1053a93fdc11d4 ("spi/drivers: Enable build of drivers with
> COMPILE_TEST") allows compile-testing drivers on platforms they're not
> meant for.

Applied, thanks.

--mOKeRhn3B7HglGBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAxxSAAoJELSic+t+oim9Zh4QAJv+K5qF3f0PLPuS7hL6Ilan
UZCzEqdNRfaDw4vMRjj9ZXfyczAT3qff+CBf3G6Mzfhv3U1skuTNgvGo6HvIfL+i
PyL0tzmgwAheemm6y/rVxxc6BCTQ2j7VLtGSN4JvHG+UsMwGcYGcVmFr+lRE3YXU
sZ9fCPNZSOv6aIGe/bDe8S2yjx/RsUcYvabQmzg41RWt1EUaE2BkcMJ0dUWoWGcb
l9BDgaa6718soHLagEkLc5xVkxQrRfQYzpzEYTXZ1ydSmspKpmOeT19Uromc0IyK
L17nLkmF/Gqife4B5PZlIavTFW2QNhYvJssPz+wmX2C6Ro6WsiYSO6qGGQ6JBRWG
NWV9VQWyElz9MQyHrnWzOBDr4zZdasTqEWn7xxQFBqRuwTE82nSK3SAMezszmKlZ
SiEoWaYwu8BHSq5enOeL98KnWo7dTenhYXY055zVh81M2+mm+jT1aCRAF9tMYtkk
t4XutxQseKr9mFXE+X8Xg30w9FJHtRM8Sa8tHrCQbbmCYpxik3nIVgUmVjombcLx
rHGGQSVRlDgXRe+645ad7bPzG6hyzZt3E9vZ4EK4KQXazgcMG/DxvgbO5iNmNasg
KcTpxbd/7B+bewoeS9ALoTBiEmd93n5/6f7v9O6p5QlbsrqE4wJSOVOzzDq6KMHt
Oq06McQB87FFpqq+I8o5
=4jZm
-----END PGP SIGNATURE-----

--mOKeRhn3B7HglGBY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
