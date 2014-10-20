From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/1 resend] spi: Using Trigger number to
 transmit/receive data
Date: Mon, 20 Oct 2014 11:33:59 +0200
Message-ID: <CAMuHMdUV6snCjhvdgeGxixsDVaU3hbeTVAguR=jzQrfXWJHDfg@mail.gmail.com>
References: <1413248264-3685-1-git-send-email-cm-hiep@jinso.co.jp>
	<1413248264-3685-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1413248264-3685-2-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Hiep-san,

On Tue, Oct 14, 2014 at 2:57 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>
> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.
>
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Thanks for your patch!

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -182,6 +182,13 @@
>  #define SPBFCR_RXRST           0x40    /* Receive Buffer Data Reset */
>  #define SPBFCR_TXTRG_MASK      0x30    /* Transmit Buffer Data Triggering Number */
>  #define SPBFCR_RXTRG_MASK      0x07    /* Receive Buffer Data Triggering Number */
> +/* QSPI on R-Car H2 */

This applies not only to H2, but to all R-Car Gen2.

> +#define SPBFCR_TXTRG_32B       0x00    /* 32Byte Transmit Buffer Triggering */
> +#define SPBFCR_TXTRG_1B                0x30    /* 1Byte Transmit Buffer Triggering */

The "32B" and "1B" don't match the documentation I have, which says for bits
5 and 4:

   "When the number of bytes of data in the transmit buffer (SPTXB) is equal
    to or less than the specified triggering number, the SPTEF flag is set to 1.

    00: 31 bytes (1 byte available)
    11: 0 byte (32 bytes available)"

(of course this could be attributed to a bad translation from Japanese
to English ;-)

See also qspi_set_send_trigger() below...

> +#define SPBFCR_RXTRG_1B                0x00    /* 32Byte Receive Buffer Triggering */
> +#define SPBFCR_RXTRG_32B       0x07    /* 1Byte Receive Buffer Triggering */

The comments seem to be swapped?

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

unsigned int len

> +{
> +       int n;

unsigned int n;

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

Haven't you swapped the two branches of the if statement?
If len >= QSPI_BUFFER_SIZE, I'd expect you only want to be woken up
if there are 32 available entries in the FIFO, i.e. when bits 5 and 4 are both
one, which is the case for your definition of SPBFCR_TXTRG_1B.

> +
> +       return n;
> +}
> +
> +static void qspi_set_receive_trigger(struct rspi_data *rspi, int len)

unsigned int len

> +{
> +       int n;

unsigned int n;

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

Perhaps the error check should just be moved inside rspi_wait_for_tx_empty(),
so you don't have to introduce a new function?

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

Perhaps the error check should just be moved inside rspi_wait_for_tx_full(),
so you don't have to introduce a new function?

>         }
> +
> +       return 0;
> +}
> +
> +static int rspi_data_out(struct rspi_data *rspi, u8 data)
> +{
> +       rspi_wait_for_tx_empty_check(rspi);

You forgot to check the return value of rspi_wait_for_tx_empty_check()?

> +       rspi_write_data(rspi, data);
> +       return 0;
> +}
> +
> +static int rspi_data_in(struct rspi_data *rspi)
> +{
> +       u8 data;
> +
> +       rspi_wait_for_rx_full_check(rspi);

You forgot to check the return value of rspi_wait_for_rx_full_check()?

>         data = rspi_read_data(rspi);
>         return data;
>  }
> @@ -614,19 +680,28 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
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
>                         return ret;

This returns zero on success...

>         }
>
> +       return 0;

... but this also returns zero if DMA cannot be used?
Shouldn't you return -EAGAIN here?

> +}
> +
> +static int rspi_common_transfer(struct rspi_data *rspi,
> +                               struct spi_transfer *xfer)
> +{
> +       int ret;
> +
> +       ret = rspi_dma_check_then_transfer(rspi, xfer);
> +       if (ret < 0)
> +               return ret;

As rspi_dma_check_then_transfer() returns zero on success,
it will continue below using PIO?

>         ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
>         if (ret < 0)
>                 return ret;
> @@ -666,12 +741,49 @@ static int rspi_rz_transfer_one(struct spi_master *master,
>         return rspi_common_transfer(rspi, xfer);
>  }
>
> +static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
> +                                       u8 *rx, unsigned int len)
> +{
> +       int i, n, ret;

unsigned int i, n;

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
> +       int ret;
> +
>         qspi_receive_init(rspi);
>
> -       return rspi_common_transfer(rspi, xfer);
> +       ret = rspi_dma_check_then_transfer(rspi, xfer);
> +       if (ret < 0)
> +               return ret;

As rspi_dma_check_then_transfer() returns zero on success,
it will continue below using PIO?

> +
> +       ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
> +                                           xfer->rx_buf, xfer->len);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
