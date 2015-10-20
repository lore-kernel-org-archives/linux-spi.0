From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8
 bits per word.
Date: Tue, 20 Oct 2015 12:22:25 +0200
Message-ID: <562615E1.4030407@atmel.com>
References: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: David Mosberger-Tang <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445288084-31805-1-git-send-email-davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 19/10/2015 22:54, David Mosberger-Tang a =E9crit :
> The DMA-slave configuration depends on the whether <=3D 8 or > 8 bits
> are transferred per word, so we need to call
> atmel_spi_dma_slave_config() with the correct value.
>=20
> Signed-off-by: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>

Thanks for having rewritten this patch! It's much more simple like this=
 ;-)

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

=46or Mark, here is the patchwork entry which can be handy:
https://patchwork.kernel.org/patch/7439931/

Best regards,

> ---
>  drivers/spi/spi-atmel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 04e48e5..855cc56 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -758,7 +758,8 @@ static int atmel_spi_next_xfer_dma_submit(struct =
spi_master *master,
> =20
>  	*plen =3D len;
> =20
> -	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
> +	if (atmel_spi_dma_slave_config(as, &slave_config,
> +				       xfer->bits_per_word))
>  		goto err_exit;
> =20
>  	/* Send both scatterlists */
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
