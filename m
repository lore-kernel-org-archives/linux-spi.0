From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: core: add spi_message_dump and spi_transfer_dump
Date: Fri, 18 Dec 2015 15:32:22 +0200
Message-ID: <CAHp75VfYQf2nfxNxNhtwwbg2_OJdiU3RFgyoyZB-THCRtfJWBA@mail.gmail.com>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
	<1450442668-2391-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450442668-2391-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 18, 2015 at 2:44 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> This implements a means to dump a spi_message or spi_transfer.
>
> spi_loop_back_test requires a means to report on failed transfers
> (including payload data), so it makes use of this.
>
> Such a functionality can also be helpful during development of
> other drivers, so it has been exposed as a general facility.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/spi/spi.c       |  146 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h |   30 ++++++++++
>  2 files changed, 176 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9964835..6e9157f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -31,6 +31,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
> +#include <linux/printk.h>
>  #include <linux/export.h>
>  #include <linux/sched/rt.h>
>  #include <linux/delay.h>
> @@ -718,6 +719,151 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
>         return 0;
>  }
>
> +static void __spi_transfer_dump_chunk(struct spi_device *spi, char *pre,
> +                                     const void *ptr, size_t start,
> +                                     size_t len)
> +{
> +       unsigned char linebuf[32 * 3 + 2 + 32 + 1];

> +       int i;

Unsigned.

> +
> +       /* because we want to use dev_info as well as print
> +        * offset value as well as pointer
> +        * we can not use print_hex_dump directly

Maybe provide a dev_hex_dump() function instead?

> +        */
> +       for (i = start; i < len; i += 16) {

To many magic numbers, like 16.

Moreover, why you have buffer almost twice longer than needed?

> +               hex_dump_to_buffer(ptr + i, min_t(int, len - i, 16),
> +                                  16, 1,
> +                                  linebuf, sizeof(linebuf), 0);

Since you print without ASCII part the whole idea with
hex_dump_to_buffer is a total overkill.

> +               dev_info(&spi->dev, "%soff=%.8x ptr=%p: %s\n",
> +                        pre, i, ptr + i, linebuf);

Documentation/printk-formats.txt is your friend. In particular a
chapter about %*ph.

> +       }
> +}
> +
> +static void spi_transfer_dump_buffer(struct spi_device *spi, char *pre,
> +                                    const void *ptr, size_t len,
> +                                    size_t dump_size)
> +{
> +       int start;
> +
> +       /* align dump_size on 32 bytes */
> +       if (dump_size & 31)
> +               dump_size += 32 - (dump_size & 31);

roundup() / rounddown().

> +
> +       /* dump the whole chunk in one go if needed */
> +       if (len <= dump_size) {
> +               __spi_transfer_dump_chunk(spi, pre, ptr, 0, len);
> +               return;
> +       }
> +
> +       /* otherwise we need to dump chunks - head first */
> +       __spi_transfer_dump_chunk(spi, pre, ptr, 0, dump_size / 2);
> +
> +       /* calculate where we need to continue */
> +       start = len - dump_size / 2;
> +       start &= ~15; /* align on the last multiple of 16 */

Magic.

> +
> +       /* message about truncating */
> +       dev_info(&spi->dev, "%s truncated - continuing at offset %04x\n",
> +                pre, start);
> +
> +       /* now the tail */
> +       __spi_transfer_dump_chunk(spi, pre, ptr, start, len);
> +}
> +
> +/**
> + * spi_transfer_dump - dump all the essential information
> + *                     of a @spi_transfer, when dump_size is set,
> + *                     then hex-dump that many bytes of data
> + * @spi:       @spi_device for which to dump this (dev_info)
> + * @msg:       @spi_message to which xfer belongs
> + * @xfer:      @spi_transfer to dump
> + * @dump_size: total number of bytes to dump of each buffer
> + *             (multiple of 32 if not rounded up)
> + */
> +void spi_transfer_dump(struct spi_device *spi,
> +                      struct spi_message *msg,
> +                      struct spi_transfer *xfer,
> +                      size_t dump_size)
> +{
> +       struct device *dev = &spi->dev;
> +
> +       dev_info(dev, "  spi_transfer@%pK\n", xfer);
> +       dev_info(dev, "    speed_hz:    %u\n", xfer->speed_hz);
> +       dev_info(dev, "    len:         %u\n", xfer->len);
> +       dev_info(dev, "    tx_nbits:    %u\n", xfer->tx_nbits);
> +       dev_info(dev, "    rx_nbits:    %u\n", xfer->rx_nbits);
> +       dev_info(dev, "    bits/word:   %u\n", xfer->bits_per_word);
> +       if (xfer->delay_usecs)
> +               dev_info(dev, "    delay_usecs: %u\n",
> +                        xfer->delay_usecs);
> +       if (xfer->cs_change)
> +               dev_info(dev, "    cs_change\n");
> +       if (xfer->tx_buf) {
> +               dev_info(dev, "    tx_buf:      %pK\n", xfer->tx_buf);
> +               if (xfer->tx_dma)
> +                       dev_info(dev, "    tx_dma:      %pad\n",
> +                                &xfer->tx_dma);
> +               if (dump_size)
> +                       spi_transfer_dump_buffer(spi, "      ",
> +                                                xfer->tx_buf, xfer->len,
> +                                                dump_size);
> +       }
> +       if (xfer->rx_buf) {
> +               dev_info(dev, "    rx_buf:      %pK\n", xfer->rx_buf);
> +               if (xfer->rx_dma)
> +                       dev_info(dev, "    rx_dma:      %pad\n",
> +                                &xfer->rx_dma);
> +               if (dump_size)
> +                       spi_transfer_dump_buffer(spi, "      ",
> +                                                xfer->rx_buf, xfer->len,
> +                                                dump_size);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(spi_transfer_dump);
> +
> +/**
> + * spi_message_dump_custom - dump a spi message with ability to have
> + *                           a custom dump method per transfer
> + * @spi:       @spi_device for which to dump this (dev_info)
> + * @msg:       @spi_message to dump
> + * @dump_size: total number of bytes to dump of each buffer
> + * @custom:    custom dump code to execute per transfer
> + * @context:   context to pass to the custom dump code
> + *
> + * uses dev_info() to dump the lines

Usually sentences are started with a capital letter and ended with a dot.

> + */
> +void spi_message_dump_custom(struct spi_device *spi,
> +                            struct spi_message *msg,
> +                            size_t dump_size,
> +                            spi_transfer_dump_custom_t custom,
> +                            void *context)
> +{
> +       struct device *dev = &spi->dev;
> +       struct spi_transfer *xfer;
> +
> +       /* dump the message */
> +       dev_info(dev, "spi_msg@%pK\n", msg);
> +       if (msg->status)
> +               dev_info(dev, "  status:         %d\n", msg->status);
> +       dev_info(dev, "  frame_length:   %zu\n", msg->frame_length);
> +       dev_info(dev, "  actual_length:  %zu\n", msg->actual_length);
> +       if (msg->complete)
> +               dev_info(dev, "  complete:       %pF\n", msg->complete);
> +       if (msg->context)
> +               dev_info(dev, "  context:        %pF\n", msg->context);
> +       if (msg->is_dma_mapped)
> +               dev_info(dev, "  is_dma_mapped\n");
> +       dev_info(dev, "  transfers-head: %pK\n", &msg->transfers);
> +
> +       /* dump transfers themselves */
> +       list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +               spi_transfer_dump(spi, msg, xfer, dump_size);
> +               if (custom)
> +                       custom(spi, msg, xfer, context);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(spi_message_dump_custom);
> +
>  /*-------------------------------------------------------------------------*/
>
>  static void spi_set_cs(struct spi_device *spi, bool enable)
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index f055a47..a17be97 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -897,6 +897,36 @@ extern int spi_setup(struct spi_device *spi);
>  extern int spi_async(struct spi_device *spi, struct spi_message *message);
>  extern int spi_async_locked(struct spi_device *spi,
>                             struct spi_message *message);
> +/*---------------------------------------------------------------------------*/
> +
> +extern void spi_transfer_dump(struct spi_device *spi,
> +                             struct spi_message *msg,
> +                             struct spi_transfer *xfer,
> +                             size_t dump_size);
> +
> +typedef void (*spi_transfer_dump_custom_t)(struct spi_device *spi,
> +                                          struct spi_message *msg,
> +                                          struct spi_transfer *xfer,
> +                                          void *context);
> +
> +extern void spi_message_dump_custom(struct spi_device *spi,
> +                                   struct spi_message *msg,
> +                                   size_t dump_size,
> +                                   spi_transfer_dump_custom_t custom,
> +                                   void *context);
> +
> +static inline void spi_message_dump_data(struct spi_device *spi,
> +                                        struct spi_message *msg,
> +                                        size_t dump_size)
> +{
> +       spi_message_dump_custom(spi, msg, dump_size, NULL, NULL);
> +}
> +
> +static inline void spi_message_dump(struct spi_device *spi,
> +                                   struct spi_message *msg)
> +{
> +       spi_message_dump_custom(spi, msg, 0, NULL, NULL);
> +}

How many users do you have for the helpers? I suggest to add a helper
whenever there are at least 2+ users present.

>
>  /*---------------------------------------------------------------------------*/
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
