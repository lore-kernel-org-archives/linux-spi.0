From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi-topcliff-pch: Transform noisy message to dev_dbg
Date: Wed, 19 Feb 2014 21:41:50 +0900
Message-ID: <20140219124150.GO2669@sirena.org.uk>
References: <1392802569-11148-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwqUOdrpdHy/KPXy"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392802569-11148-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wwqUOdrpdHy/KPXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 10:36:07AM +0100, Alexander Stein wrote:
> If during a SPI transfer with len larger than PCH_MAX_FIFO_DEPTH and the
> IRQ handler happens to be called when the transmit FIFO is already empty,
> and SPSR_FI_BIT is set consequently, the message
> "spi_master spi32766: pch_spi_handler_sub : Transfer is not completed"
> is spammed to the systemlog, because tx_index has already increased
> further due to the next bytes to be written. This case is uncritical as
> new bytes have already been written.

When you say "spammed" does that mean "printed once" or "is continually
printed"?  I'd have assumed the latter in which case it might be better
to go as low as _vdbg() or even remove the message entirely if it's not
possible to suppress it entirely.

--wwqUOdrpdHy/KPXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBKaLAAoJELSic+t+oim9FvMP/ix+qi0z6pXraWOdCJuSrjSr
1+IrWo1bCbK8SSUTZTRQWJ/9d3qJ+l0j/S+AmP/d9m+upJlpLATctxtsDa7kgYea
UJr9I5wabQiaNIH3xCURn4grSWf4eD3Y7aLsVPCoLYWsTALYSNIIYqPmYoRxVpzE
3WnkY4S4+PT6vk0ZA4i9NNFJ3rMeFefK1QDD+5pbKKRmV9p9RlnAXXXZMnMHjMho
oKh5CxfBfEmElCqvL6Ky9XzrwhLpedTmUfGlwByCUioJvXfMXtd7FGf3LGyOvCGc
TXMmESH62OJWPt330HdJdJKe1igZD36bXs1LEKwskUGvrp42cbIN2NotQlT/yTtr
eHxeV+Lptq8pUge8jwTu7+/w42/y3vY3lotGO50RkRrfLzWzEPYrGI1bedrOXdnk
EeMW7f9KRLM8RnZlJhW443DgTLX0byNM1fuxFnj6l0vCESbsAb9C0KZsTVKhMy22
aWeTC7uvmTC7soC4vmgsbBhoeapahI5UT5IleNvcECR0LMZOM4El8Y2ighCowm31
4nbB994aCOAH86agYu3w5neCruj0fCOOh2mg36vfsU3GXRdk8bnziJfXw7Pql6re
L7PRTlJPHL72sSNFoLXjAeTTQjdLzEOe3YS6tEjKIrPXctDIYO3jcWyoWbyQOr+S
X7WVHetocUOKizv80oc5
=XPAy
-----END PGP SIGNATURE-----

--wwqUOdrpdHy/KPXy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
