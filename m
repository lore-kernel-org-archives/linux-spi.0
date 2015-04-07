From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive data
Date: Tue, 7 Apr 2015 20:51:11 +0200
Message-ID: <CAMuHMdWcfij=gFwT9c5wT1+mBT7Q-Fc5_qzqSjLk4RvOEsUGgA@mail.gmail.com>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp>
	<1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414034053-14750-2-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hiep-san,

On Thu, Oct 23, 2014 at 5:14 AM, Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>
> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.

Please accept my apologies for these late review comments.
I had completely forgotten about your patch, until I noticed Mark had
applied it.

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -614,19 +667,29 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
>         return __rspi_can_dma(rspi, xfer);
>  }
>
> -static int rspi_common_transfer(struct rspi_data *rspi,
> -                               struct spi_transfer *xfer)
> +static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
> +                                        struct spi_transfer *xfer)
>  {
> -       int ret;
> -
>         if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
>                 /* rx_buf can be NULL on RSPI on SH in TX-only Mode */
> -               ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
> +               int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
>                                         xfer->rx_buf ? &xfer->rx_sg : NULL);
>                 if (ret != -EAGAIN)
> -                       return ret;
> +                       return 0;

Shouldn't you propagate "ret" here, instead of returning zero?
Else you will turn a failure into a success below (see "here").

>         }
>
> +       return -EAGAIN;
> +}
> +
> +static int rspi_common_transfer(struct rspi_data *rspi,
> +                               struct spi_transfer *xfer)
> +{
> +       int ret;
> +
> +       ret = rspi_dma_check_then_transfer(rspi, xfer);
> +       if (ret != -EAGAIN)
> +               return ret;

... here.

> +
>         ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
>         if (ret < 0)
>                 return ret;
> @@ -666,12 +729,59 @@ static int rspi_rz_transfer_one(struct spi_master *master,
>         return rspi_common_transfer(rspi, xfer);
>  }
>
> +static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,

I guess this should be called "qspi_trigger_transfer_out_in" (without "t")?

> +                                       u8 *rx, unsigned int len)

>  static int qspi_transfer_out_in(struct rspi_data *rspi,
>                                 struct spi_transfer *xfer)
>  {
> +       int ret;
> +
>         qspi_receive_init(rspi);
>
> -       return rspi_common_transfer(rspi, xfer);
> +       ret = rspi_dma_check_then_transfer(rspi, xfer);
> +       if (ret != -EAGAIN)
> +               return ret;
> +
> +       ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
> +                                           xfer->rx_buf, xfer->len);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;

You could just write

      return qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
                                           xfer->rx_buf, xfer->len);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
