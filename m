From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting cs-gpio
Date: Tue, 09 Feb 2016 15:49:24 -0800
Message-ID: <87d1s54f7f.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
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
In-Reply-To: <1455041435-8015-4-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

stephanolbrich-Mmb7MZpHnFY@public.gmane.org writes:

> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> When using reverse polarity for clock (spi-cpol) on a device
> the clock line gets altered after chip-select has been asserted
> resulting in an additional clock beat, which confuses hardware.
>
> To avoid this situation this patch moves the setup of polarity
> (spi-cpol and spi-cpha) outside of the chip-select into
> prepare_message, which is run prior to asserting chip-select.

This patch surprised me.  I would have thought that the solution was to
just write the updated CNTL bits for CPOL and wait a moment whenever it
changes.  The CS only gets asserted later on when we get some data in
the TX FIFO, so I think you're just reducing the chance of losing the
race to get our inverted clock noticed by the device before the CS gets
asserted.

If we're only talking to a device that does an inverted clock, it seems
silly that we're resetting the hardware back to non-inverted clock after
every transfer/message.

I'd be OK with the patch anyway, since you reduce the number of resets
for a multi-transfer message, except for what I think is bug...

> Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/spi/spi-bcm2835aux.c | 54 +++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index d2f0067..b90aa34 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c=20=20=20=20
> @@ -218,9 +218,9 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, =
void *dev_id)
>  			BCM2835_AUX_SPI_CNTL1_IDLE);
>  	}
>=20=20
> -	/* and if rx_len is 0 then wake up completion and disable spi */
> +	/* and if rx_len is 0 then disable interrupts and wake up completion */
>  	if (!bs->rx_len) {
> -		bcm2835aux_spi_reset_hw(bs);
> +		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>  		complete(&master->xfer_completion);
>  	}
>=20=20
> @@ -313,9 +313,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct sp=
i_master *master,
>  		}
>  	}
>=20=20
> -	/* Transfer complete - reset SPI HW */
> -	bcm2835aux_spi_reset_hw(bs);
> -
>  	/* and return without waiting for completion */
>  	return 0;
>  }
> @@ -336,10 +333,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_ma=
ster *master,
>  	 * resulting (potentially) in more interrupts when transferring
>  	 * more than 12 bytes
>  	 */
> -	bs->cntl[0] =3D BCM2835_AUX_SPI_CNTL0_ENABLE |
> -		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
> -		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
> -	bs->cntl[1] =3D BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>=20=20
>  	/* set clock */
>  	spi_hz =3D tfr->speed_hz;

Just below this block, we update cntl[0] with the transfer's speed bits,
so now that you're not resetting cntl[0] on each transfer, their speeds
will all get ORed all together by the end.  I think you could just mask
out the max speed before setting the new one.

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWunsEAAoJELXWKTbR/J7oepkQAK0L1olcKlEg1Wt4iWQ8M6y/
b/VXe3qmhfCFgWttbUV44u2VMF8F4hoKcXZBEos/Eb8a+UkPELeGHcxGJO3EQ23h
KHxzqR0pCq/rRAjRh1LRjc96JHO/LsoKeGs+arWhQfJfqFABdAV8pAgWkH1TtTd2
dbImmTuAxPRtQwojIaaL2tw8nF6cHEvVeR+bdWVov3JnUU7Jtr4rjYd5ovmwzDvW
ruxRzSNZIi4i13pq3MmmgtgeU7qXCll29v9g3djfqO+1PVLZ9ftO5CpwLolpgcvz
NMh+91jdpuzZG73Eq49ohvJ8rcdQKST56QneOdVDgcSqaN5e8f+6Oy1x2rVczFH3
1HsaMsnGTOXf3PztlU6ZqTGpCK/Zii6YAkAIXMloa40O9R4qyDyI3fWytglIA6OL
1SzI9mMnnuAMURarsijV93slWCQRjvHskr83N6obMNAGo3OTsWmJ7ueghs6K+UGE
HdMHX88KIfTz3/11N9Dt/ovTQWfoH9QYKrW0RnSIPaDQb87kTczuxrX+VzC+LG6d
gIoc+oTXNTSgZ8Z+79KnJqyxplAXKl1nc3B1jxxfV1mc7bj4TnutPQ7XwLmxlTro
kuOxgVH4G6jNH/BRD1qUphmMteqRfBrcvxOs+W9mW29UybzcSn2D1l3OGjdrcqvj
1G95CAFpwAETZm3D9FqA
=rOvQ
-----END PGP SIGNATURE-----
--==-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
