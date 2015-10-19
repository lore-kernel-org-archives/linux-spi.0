From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi-atmel.c: fix DMA for bits_per_word > 8
Date: Mon, 19 Oct 2015 18:01:38 +0200
Message-ID: <562513E2.4090303@atmel.com>
References: <CALnQHM3WxNDV3xzJwRfGRVTMYL1mo44VbBb2YawZVUzn0CzFfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SPI SUBSYSTEM <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALnQHM3WxNDV3xzJwRfGRVTMYL1mo44VbBb2YawZVUzn0CzFfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

David,

It seems that your email client is doing funny things with the source
code whitespace. Anyway, I can deal with this and re-format your patch:
no problem. For later patches I advice you to use "git format-patch"
command.

Still, see comments below...

Le 13/10/2015 00:32, David Mosberger a =C3=A9crit :
> I need the patch below to make DMA work in spi-atmel.c when bits_per_=
word > 8.

A little bit more explanation would be good.

>   --david

I would need your "Signed-off-by:" tag.

> --=20
> eGauge Systems LLC, http://egauge.net/, 1.877-EGAUGE1, fax 720.545.97=
68
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 04e48e5..7bb361a 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -711,6 +711,7 @@ static void atmel_spi_next_xfer_pio(struct
> spi_master *master,
>   * Submit next transfer for DMA.
>   */
>  static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
> +  struct spi_message *msg,
>   struct spi_transfer *xfer,
>   u32 *plen)
>  {
> @@ -721,7 +722,7 @@ static int atmel_spi_next_xfer_dma_submit(struct
> spi_master *master,
>   struct dma_async_tx_descriptor *txdesc;
>   struct dma_slave_config slave_config;
>   dma_cookie_t cookie;
> - u32 len =3D *plen;
> + u32 len =3D *plen, bpw;
>=20
>   dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
>=20
> @@ -758,7 +759,11 @@ static int atmel_spi_next_xfer_dma_submit(struct
> spi_master *master,
>=20
>   *plen =3D len;
>=20
> - if (atmel_spi_dma_slave_config(as, &slave_config, 8))
> + bpw =3D xfer->bits_per_word;
> + if (!bpw)

I assume that xfer->bits_per_word must be filled with the proper value.
So why do you need this test and de additional assignment below? Does i=
t
come from a bad experience with the "xfer->bits_per_word" value being e=
mpty?

> + bpw =3D msg->spi->bits_per_word;
> +
> + if (atmel_spi_dma_slave_config(as, &slave_config, bpw))

I may have called bpw variable as "bits" like elsewhere in this driver:
it's a detail though.

>   goto err_exit;
>=20
>   /* Send both scatterlists */
> @@ -1316,8 +1321,8 @@ static int atmel_spi_one_transfer(struct
> spi_master *master,
>   atmel_spi_pdc_next_xfer(master, msg, xfer);
>   } else if (atmel_spi_use_dma(as, xfer)) {
>   len =3D as->current_remaining_bytes;
> - ret =3D atmel_spi_next_xfer_dma_submit(master,
> - xfer, &len);
> + ret =3D atmel_spi_next_xfer_dma_submit(master, msg,
> +     xfer, &len);
>   if (ret) {
>   dev_err(&spi->dev,
>   "unable to use DMA, fallback to PIO\n");

Ok, the patch seems reasonable. So, can you please answer my main
question and give me the permission to add your "Signed-off-by:" tag or
re-send me a more standard patch...

Thanks a lot for your work on this driver David.
Best regards,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
