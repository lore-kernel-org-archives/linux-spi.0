From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Using Trigger number to transmit/receive data
Date: Tue, 30 Sep 2014 19:17:47 +0200
Message-ID: <CAMuHMdU3riiMHpYQ8VSjhBnoi9CAJgDHvbkWKwvgDQFefTmi9g@mail.gmail.com>
References: <1412045974-6715-1-git-send-email-cm-hiep@jinso.co.jp>
	<1412045974-6715-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412045974-6715-2-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hiep-san,

On Tue, Sep 30, 2014 at 4:59 AM, Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>
> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.
>
> Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

Thanks for your patch!

Please CC linux-spi on SPI patches.

I haven't tried your patch yet, but you can already find one comment below.

> ---
>  drivers/spi/spi-rspi.c | 110 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 101 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index ad87a98..78bb8aa 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -182,6 +182,13 @@
>  #define SPBFCR_RXRST           0x40    /* Receive Buffer Data Reset */
>  #define SPBFCR_TXTRG_MASK      0x30    /* Transmit Buffer Data Triggering Number */
>  #define SPBFCR_RXTRG_MASK      0x07    /* Receive Buffer Data Triggering Number */
> +/* QSPI on R-Car H2 */
> +#define SPBFCR_TXTRG_32B       0x00    /* 32Byte Transmit Buffer Triggering */
> +#define SPBFCR_TXTRG_1B                0x30    /* 1Byte Transmit Buffer Triggering */
> +#define SPBFCR_RXTRG_1B                0x00    /* 32Byte Receive Buffer Triggering */
> +#define SPBFCR_RXTRG_32B       0x07    /* 1Byte Receive Buffer Triggering */
> +
> +#define QSPI_BUFFER_SIZE        32
>
>  struct rspi_data {
>         void __iomem *addr;
> @@ -371,6 +378,52 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
>         return 0;
>  }
>
> +static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
> +{
> +       u8 data;
> +
> +       data = rspi_read8(rspi, reg);
> +       data &= ~mask;
> +       data |= (val & mask);
> +       rspi_write8(rspi, data, reg);
> +}
> +
> +static int qspi_set_send_trigger(struct rspi_data *rspi, int len)
> +{
> +       int n;
> +
> +       n = min(len, QSPI_BUFFER_SIZE);
> +
> +       if (len >= QSPI_BUFFER_SIZE) {
> +               /* sets triggering number to 32 bytes */
> +               qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +                            SPBFCR_TXTRG_32B, QSPI_SPBFCR);
> +       } else {
> +               /* sets triggering number to 1 byte */
> +               qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +                            SPBFCR_TXTRG_1B, QSPI_SPBFCR);
> +       }
> +
> +       return n;
> +}
> +
> +static void qspi_set_receive_trigger(struct rspi_data *rspi, int len)
> +{
> +       int n;
> +
> +       n = min(len, QSPI_BUFFER_SIZE);
> +
> +       if (len >= QSPI_BUFFER_SIZE) {
> +               /* sets triggering number to 32 bytes */
> +               qspi_update(rspi, SPBFCR_RXTRG_MASK,
> +                            SPBFCR_RXTRG_32B, QSPI_SPBFCR);
> +       } else {
> +               /* sets triggering number to 1 byte */
> +               qspi_update(rspi, SPBFCR_RXTRG_MASK,
> +                            SPBFCR_RXTRG_1B, QSPI_SPBFCR);
> +       }
> +}
> +
>  #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
>
>  static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
> @@ -410,27 +463,40 @@ static inline int rspi_wait_for_rx_full(struct rspi_data *rspi)
>         return rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE);
>  }
>
> -static int rspi_data_out(struct rspi_data *rspi, u8 data)
> +static int rspi_wait_for_tx_empty_check(struct rspi_data *rspi)
>  {
>         int error = rspi_wait_for_tx_empty(rspi);
>         if (error < 0) {
>                 dev_err(&rspi->master->dev, "transmit timeout\n");
>                 return error;
>         }
> -       rspi_write_data(rspi, data);
> +
>         return 0;
>  }
>
> -static int rspi_data_in(struct rspi_data *rspi)
> +static int rspi_wait_for_rx_full_check(struct rspi_data *rspi)
>  {
> -       int error;
> -       u8 data;
> -
> -       error = rspi_wait_for_rx_full(rspi);
> +       int error = rspi_wait_for_rx_full(rspi);
>         if (error < 0) {
>                 dev_err(&rspi->master->dev, "receive timeout\n");
>                 return error;
>         }
> +
> +       return 0;
> +}
> +
> +static int rspi_data_out(struct rspi_data *rspi, u8 data)
> +{
> +       rspi_wait_for_tx_empty_check(rspi);
> +       rspi_write_data(rspi, data);
> +       return 0;
> +}
> +
> +static int rspi_data_in(struct rspi_data *rspi)
> +{
> +       u8 data;
> +
> +       rspi_wait_for_rx_full_check(rspi);
>         data = rspi_read_data(rspi);
>         return data;
>  }
> @@ -666,12 +732,38 @@ static int rspi_rz_transfer_one(struct spi_master *master,
>         return rspi_common_transfer(rspi, xfer);
>  }
>
> +static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
> +                                       u8 *rx, unsigned int len)
> +{
> +       int i, n, ret;
> +
> +       while (len > 0) {
> +               n = qspi_set_send_trigger(rspi, len);
> +               qspi_set_receive_trigger(rspi, len);
> +               if (n == QSPI_BUFFER_SIZE) {
> +                       rspi_wait_for_tx_empty_check(rspi);
> +                       for (i = 0; i < n; i++)
> +                               rspi_write_data(rspi, *tx++);
> +                       rspi_wait_for_rx_full_check(rspi);
> +                       for (i = 0; i < n; i++)
> +                               *rx++ = rspi_read_data(rspi);
> +               } else {
> +                       ret = rspi_pio_transfer(rspi, tx, rx, n);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               len -= n;
> +       }
> +
> +       return 0;
> +}
> +
>  static int qspi_transfer_out_in(struct rspi_data *rspi,
>                                 struct spi_transfer *xfer)
>  {
>         qspi_receive_init(rspi);
> -
> -       return rspi_common_transfer(rspi, xfer);
> +       return qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
> +                                           xfer->rx_buf, xfer->len);

So this will always use PIO mode, even if DMA is available?

>  }
>
>  static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
> --
> 1.9.1

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
