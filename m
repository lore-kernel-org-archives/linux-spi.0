From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: bcm2835aux: disable tx fifo empty irq
Date: Tue, 09 Feb 2016 15:45:32 -0800
Message-ID: <87io1x4fdv.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
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
In-Reply-To: <1455041435-8015-3-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

stephanolbrich-Mmb7MZpHnFY@public.gmane.org writes:

> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> The tx empty irq can be disabled when all data was copied.
> This prevents unnecessary interrupts while the last bytes are sent.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/spi/spi-bcm2835aux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index ecc73c0..d2f0067 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -212,6 +212,12 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq,=
 void *dev_id)
>  		ret =3D IRQ_HANDLED;
>  	}
>=20=20
> +	if (!bs->tx_len) {
> +		/* disable tx fifo empty interrupt */
> +		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
> +			BCM2835_AUX_SPI_CNTL1_IDLE);
> +	}
> +
>  	/* and if rx_len is 0 then wake up completion and disable spi */
>  	if (!bs->rx_len) {
>  		bcm2835aux_spi_reset_hw(bs);
> --=20
> 2.5.0

Right, we don't want to come back in here with a spurious TX empty
interrupt while we wait for the RX bits to trickle in through the FIFO.
I'm having a hard time reasoning through how likely this would be, but
it seems like a good change.

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

Aside: I think I see a problem that we reset the hardware before it has
asserted SPI_STAT_BUSY, since we reset as soon as we've collected our RX
data (!bs->rx_len).  That means we've potentially missed the trailing
hold time on CS at the end of the transfer, and it's going to resume at
the same point in its state machine when we reassert CNTL0_ENABLE for
the next transfer.  That doesn't seem like what we want.

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWunodAAoJELXWKTbR/J7o0VoP/0XKO4uLSknx5WGGwPiCIMGi
1AA28qHJHsFyxgi53EWa5SkwHs/A/4DB68MdRTDVdJEICY0MyYDXVM+ubFjfmWed
Xv9HZR/rZ82BMg3U2VDP4WLgFC+WOdXYs8QNaZlejC/iWNw8KAJYkLoVLbbt3z3H
hLevw2wsG/dw0cfB/QtIz7RJAx5TI+Lmt6WPoZw7KdKq/nrHPkrQ+ZCu7oeHh758
BYsS+gsIrwtyQGawInJl+t3eZvp8Y7tLDrnIIFWjL/uFAvnIBZ9CefIRy9bkbg5t
S1+7CGIYo+kUoSg4rS0wtc5GlymFQap4QZGfVieZAze9+vp6vNqs5Sf1E2ENVg+X
0N1s5XJfCQ3zY6/b7DrSgkZkdxObGtnUlXc/kxGHcb0q4cUWbO9WtmKi9VELNZeY
htiEUl7A5a2bYKHWcw2s1BChjWC2lytTNBe5km72GbSiUx8AKvm3+/lpJFOSlDjr
SLw1IG6th4hDJ19XwwKfli6xopBpOsvm1BwCBfdq8nncAiKmXd3MD5ntP3HQN46T
a0JcNm4vqqtAzfxJvb+ZArwRpiLtrjzd0NxgY/hELYpvXuJfSg6NFUfZjLFBMK3c
Yt4qUYT1vp7JwHpSBDpBby6dQDYLAiaeUQLpuTUC+Lhcqs4DhlGP3YlyjwZkOYAA
PCr/D2cAGoHFoT9CFvIl
=0ZaT
-----END PGP SIGNATURE-----
--==-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
