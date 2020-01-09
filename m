From: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: Raise maximum number of slaves to 4
Date: Thu, 09 Jan 2020 13:52:54 +0100
Message-ID: <b0f26f7f4c265dc9b14fba1cb4b0d4546da1f45a.camel@suse.de>
References: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3753323019679316588=="
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============3753323019679316588==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-dIc7VbFbXRwHFM7LWXk+"


--=-dIc7VbFbXRwHFM7LWXk+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-01-09 at 13:23 +0100, Lukas Wunner wrote:
> The "RevPi Connect Flat" PLC offered by KUNBUS has 4 slaves attached
> to the BCM2835 SPI master.  Raise the maximum number of slaves in the
> driver accordingly.
>=20
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>

Thanks!

>  drivers/spi/spi-bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index b784c9fdf9ec..11c235879bb7 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -68,7 +68,7 @@
>  #define BCM2835_SPI_FIFO_SIZE		64
>  #define BCM2835_SPI_FIFO_SIZE_3_4	48
>  #define BCM2835_SPI_DMA_MIN_LENGTH	96
> -#define BCM2835_SPI_NUM_CS		3   /* raise as necessary */
> +#define BCM2835_SPI_NUM_CS		4   /* raise as necessary */
>  #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
>  				| SPI_NO_CS | SPI_3WIRE)
> =20


--=-dIc7VbFbXRwHFM7LWXk+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4XIiYACgkQlfZmHno8
x/53xAgAhpR+IrNKIWkC+R2shaCd4Yj99SBmS3YeSC0RCOwUUDvuXeVsqsIhZ1eT
GFY11ghFtnI1JoRLEoXl+M5G+8d1CQpERaIDWwBkkbZ3IENfieGiqY0a5qRetXIs
w5fWpUkPfZYa44uAwcsXLQ2E8b9dQTopGJlWUk1waFq3H1b0A4AFUD9TqVpg5t+e
QsLTEeYrRNd7HoKy2m9tSF++hpscCGWwYxZYQIBFO0OazrTx73H7x9+Cn+kqjpNd
DFKqhEM+N+TWryl5KcEomerNRlXMT+4UB3xTY9FGWW6PFyIP3/Dq9udiUHHFD7En
GwLzxT78n05uEF0l/QsYdAQ2hlX3OQ==
=gJlq
-----END PGP SIGNATURE-----

--=-dIc7VbFbXRwHFM7LWXk+--



--===============3753323019679316588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============3753323019679316588==--
