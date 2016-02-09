From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: bcm2835aux: fix bitmask defines
Date: Tue, 09 Feb 2016 15:44:02 -0800
Message-ID: <87lh6t4fgd.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-2-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

stephanolbrich-Mmb7MZpHnFY@public.gmane.org writes:

> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> The bitmasks for txempty and idle interrupts were interchanged.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/spi/spi-bcm2835aux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7de6f84..ecc73c0 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -73,8 +73,8 @@
>=20=20
>  /* Bitfields in CNTL1 */
>  #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
> -#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
> -#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040
> +#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
> +#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
>  #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
>  #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001

Confirmed by looking at the hardware.

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWunnCAAoJELXWKTbR/J7o2NoP/j2JeYW7jM0DWRMrPOK2W+bA
4zp6o0BvL7pizaBNDBCJyibW4PyAEgYOnDGNkwAIFUZhzj36hIhtBP5aXnlxVGQC
HgMIxtg7NAvCsjHdq2zC0rIOwnCzqKLz7Igxc4lvzB+KcGr1ZuxHGetYGS8Jov4Q
EMXbBgj5rLfdvxudwY3WZQsDT6o3ITqDHyKVgt++BK41efh3vH9hzyVy9OoACO5U
23P0EBnJV7z1VnIREzScoHyAs/1GoRWCIepy8hHQ9q06YRkgqGvz0WdY0Sa+3Isy
JSGrZSekCzTKJ4j60FfUm3BOPfkq8CdKndaWCsdkS55+FFkbEJIHrKS6IEudTIVW
JBVc2yEQMqF9faAURkTCj756pt1NNj1wP9gRCH8Z2lzUDQ00vlz5ihcgVehwnxm9
yUKAaH17CwulDMg1J0tzhA54guHwAzCwmyzNfn0u9pkDyYvDMCaYo+4KhdMW1aRa
2KXzKK/4lwBskFGGS4HO34ILPEsTvDM3TJ6/8yRjr0M6wKsgTssrdUKfhhWXhhVs
NYyqmVVFIVHPKHjTSItc00WYLNmyuVMzupOvNc9hLXdc4HIYqy6nGtUfPJuhRTah
44EqyeiIVzsXcpLSLMgrw4FlezHEIAkFq9gWtT0spD6l4aY0KKsqywpEmJ4V+uJI
39R3EgYb/hnop/yAjZ6I
=mEV0
-----END PGP SIGNATURE-----
--==-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
