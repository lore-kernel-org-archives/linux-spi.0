From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
Date: Tue, 09 Feb 2016 16:13:06 -0800
Message-ID: <87a8n94e3x.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
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
In-Reply-To: <1455041435-8015-5-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

stephanolbrich-Mmb7MZpHnFY@public.gmane.org writes:

> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> The auxiliary spi supports only CPHA=3D0 modes as the first bit is
> always output to the pin before the first clock cycle. In CPHA=3D1
> modes the first clock edge outputs the second bit hence the slave
> can never read the first bit.
>
> Also the CPHA registers switch between clocking data in/out on
> rising/falling edge hence depend on the CPOL setting.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/spi/spi-bcm2835aux.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index b90aa34..169f521 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct sp=
i_master *master,
>  	bs->cntl[1] =3D BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>=20=20
>  	/* handle all the modes */
> -	if (spi->mode & SPI_CPOL)
> +	if (spi->mode & SPI_CPOL) {
>  		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPOL;
> -	if (spi->mode & SPI_CPHA)
> -		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
> -			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
> -
> +		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
> +	} else {
> +		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_IN;
> +	}
>  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);

(Note for other readers: A better name for CNTL0_CPHA_* would be
CNTL0_*_RISING).

I think you're right about not actually supporting CPHA.  I don't see
wany way to keep bit 1 out lasting through the first full clock cycle.
I think Stefan's right that we should drop CPHA from MODE_BITS
(actually, MODE_BITS would be nicer if we just merged it into its one
user, I think).

However, this hunk appears to be correct and would fix the timing of our
data going out in the CPOL=3D0 case and of sampling IN data for CPOL=3D1.

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWuoCTAAoJELXWKTbR/J7odKYQAJXoXzvKq9eueKwvh7LpUWX4
EEhUE5JbGmY3gLGJlExl/3JFwd3fCfiJjvwGMPLQqVpWHMatIuHF6IIIDKatFnU9
ImnbmKfznlLnfuSX8QjjQMjvhny61A6fbzkkh9dzthC2z8lGRB+U/KrkDu3+HGeM
y4OLAq2L2YyIN3YUJfLqkBFSW+ZmicOyctfoacOdY7p611aM8acAm0g3Vi3LBcpU
zPn7bQGBkyifSVsuHzKkQ5cyV7hesS80kRxmY8gbepqOItDOslBtfZBLjbR3Hd/I
pvOQPEy+NEUUVbrS+0oY5eP1bn4zX1bK8nKUvqSTa4BKD2Km1lpMOy7e6ldX2c6+
c0CbfXxyO02MYxG1eNLJ6JSP5K63KoXZ1gaZsVVGeKm9EB/o6gnNnRNkyCN5TcHR
bonfQpoPAWJErURUcfnTNIjnfhcE1CoSlxOCbUIHxXYDPjZvWWjZRKopHAmHKJXF
xsmLxoBzuDsJt8EaAZbWRrQAlT8j/6cWbkKW1m3G4Y+BG7jH30t1ZVvnKDKJUaEn
zC2icZPnHbA+smn3rp1c9JoxLbt28brDaEEh+HG5RY6vD7JQAB1IRhFtl+XDpG5e
kX/Sfhow7GuUi+mzcpraS2smVLrr785ofkQVbXqvzxA74MFEhq/tT4d3B3tjd0Wp
9dYUjj86o5ZYfNp+xm44
=NVsW
-----END PGP SIGNATURE-----
--==-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
