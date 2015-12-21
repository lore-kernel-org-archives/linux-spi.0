From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/8] spi: core: add spi_message_dump and spi_transfer_dump
Date: Mon, 21 Dec 2015 14:42:24 +0200
Message-ID: <CAHp75Vc+THQ6xojJ0cMcjuLxe=KPNHB7KB2pa0yqhr-WnNga4g@mail.gmail.com>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
	<1450698772-2379-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 21, 2015 at 1:52 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
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
>  drivers/spi/spi.c       |  169 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h |   24 +++++++
>  2 files changed, 193 insertions(+)
>
> Changelog:
> V1->V2: * changes recommended by Andy Shevchenko
>         * slight reorganisation of code - specifically remove
>           hex_dump_to_buffer and use %*ph instead
>         * removal of one helper function and renaming another
>         * change in method parameters to allow changing the amount
>           of lines to dump at the head independently from tail
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9964835..bf623db 100644
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
> @@ -718,6 +719,174 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
>         return 0;
>  }
>
> +const unsigned spi_dump_bytes_per_line = 16;
> +static void __spi_transfer_dump_chunk(struct spi_device *spi, char *prefix,
> +                                     const void *ptr, size_t start,
> +                                     size_t len)
> +{
> +       const size_t spi_dump_bytes_per_line = 16;
> +       char hexdata[spi_dump_bytes_per_line * 3];
> +       size_t i, l;
> +
> +       for (i = start; i < len; i += spi_dump_bytes_per_line) {
> +               /* format the next 16 bytes */
> +               snprintf(hexdata, sizeof(hexdata), "%16ph", ptr + i);
> +
> +               /* truncate the unnecessarily printed bytes */

Again, you don't need the intermediate buffer along with this all
stuff. Just use %*ph properly (hint: star is put here and elsewhere on
purpose).

drivers/hid/i2c-hid/i2c-hid.c:187:      i2c_hid_dbg(ihid, "%s:
cmd=%*ph\n", __func__, length, cmd->data);

> +               l = min_t(size_t, len - i, spi_dump_bytes_per_line) * 3 - 1;
> +               hexdata[l] = 0;
> +
> +               /* and print data including address and offset */
> +               dev_info(&spi->dev, "%soff=0x%.5zx ptr=0x%pK: %s\n",
> +                        prefix, i, ptr + i, hexdata);
> +       }
> +}
> +
> +static void spi_transfer_dump_buffer(struct spi_device *spi, char *prefix,
> +                                    const void *ptr, size_t len,
> +                                    size_t head_len, size_t tail_len)
> +{

The function body looks too complicated. Can you describe what
function does in different cases?

> +       size_t tail_start;
> +
> +       /* dump head if requested */
> +       if (head_len) {
> +               /* calculate effective head_len - aligning if necessary */
> +               head_len = (len <= head_len) ?
> +                          len :
> +                          roundup(head_len, spi_dump_bytes_per_line);
> +
> +               /* dump the head */
> +               __spi_transfer_dump_chunk(spi, prefix, ptr, 0, head_len);
> +
> +               /* if we dumped everything return immediately */
> +               if (len == head_len)
> +                       return;
> +       }
> +
> +       /* return if no tail_len is requested */
> +       if (!tail_len)
> +               return;
> +
> +       /* calculate real tail start offset aligning it */
> +       tail_start = (tail_len >= len) ?
> +                    head_len :
> +                    rounddown(len - tail_len, spi_dump_bytes_per_line);
> +
> +       /* special handling needed if we have been dumping head */
> +       if (head_len) {
> +               if (tail_start > head_len)
> +                       /* we are not overlapping */
> +                       dev_info(&spi->dev,
> +                                "%struncated - continuing at offset %04x\n",
> +                                prefix, tail_start);
> +               else
> +                       /* we are overlapping, so continue at head_len */
> +                       tail_start = head_len;
> +       }
> +
> +       /* dump the tail */
> +       __spi_transfer_dump_chunk(spi, prefix, ptr, tail_start, len);
> +}
> +
> +/**
> + * spi_transfer_dump - dump all the essential information
> + *                     of a @spi_transfer, when dump_size is set,
> + *                     then hex-dump that many bytes of data
> + * @spi:       @spi_device for which to dump this (dev_info)
> + * @msg:       @spi_message to which xfer belongs
> + * @xfer:      @spi_transfer to dump
> + * @head_len: bytes to dump from the start of the buffers
> + *            (rounded up to multiple of 16)
> + * @tail_len: bytes to dump from the end of the buffers
> + *            (rounded up so that tail dump starts 16 byte aligned)
> + */
> +void spi_transfer_dump(struct spi_device *spi,
> +                      struct spi_message *msg,
> +                      struct spi_transfer *xfer,
> +                      size_t head_len, size_t tail_len)
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
> +               if (head_len | tail_len)

I think || looks a bit more logical here and below.

> +                       spi_transfer_dump_buffer(spi, "\t",
> +                                                xfer->tx_buf, xfer->len,
> +                                                head_len, tail_len);
> +       }
> +       if (xfer->rx_buf) {
> +               dev_info(dev, "    rx_buf:      %pK\n", xfer->rx_buf);
> +               if (xfer->rx_dma)
> +                       dev_info(dev, "    rx_dma:      %pad\n",
> +                                &xfer->rx_dma);
> +               if (head_len | tail_len)

> +                       spi_transfer_dump_buffer(spi, "\t",
> +                                                xfer->rx_buf, xfer->len,
> +                                                head_len, tail_len);

Is the DMA buffer is in coherent memory? Otherwise you have to call
dma_sync for it before reading on CPU side.

> +       }
> +}
> +EXPORT_SYMBOL_GPL(spi_transfer_dump);
> +
> +/**
> + * spi_message_dump_custom - dump a spi message with ability to have
> + *                           a custom dump method per transfer
> + * @spi:       @spi_device for which to dump this (dev_info)
> + * @msg:       @spi_message to dump
> + * @head_len: bytes to dump from the start of the buffers
> + *            (rounded up to multiple of 16)
> + * @tail_len: bytes to dump from the end of the buffers
> + *            (rounded up so that tail dump starts 16 byte aligned)
> + * @custom:    custom dump code to execute per transfer
> + * @context:   context to pass to the custom dump code
> + *
> + * Uses dev_info() to dump the lines.
> + */
> +void spi_message_dump_custom(struct spi_device *spi,
> +                            struct spi_message *msg,
> +                            size_t head_len, size_t tail_len,
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
> +               spi_transfer_dump(spi, msg, xfer, head_len, tail_len);
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
> index f055a47..13f8f06 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -897,6 +897,30 @@ extern int spi_setup(struct spi_device *spi);
>  extern int spi_async(struct spi_device *spi, struct spi_message *message);
>  extern int spi_async_locked(struct spi_device *spi,
>                             struct spi_message *message);
> +/*---------------------------------------------------------------------------*/
> +
> +extern void spi_transfer_dump(struct spi_device *spi,
> +                             struct spi_message *msg,
> +                             struct spi_transfer *xfer,
> +                             size_t dump_head, size_t dump_tail);
> +
> +typedef void (*spi_transfer_dump_custom_t)(struct spi_device *spi,
> +                                          struct spi_message *msg,
> +                                          struct spi_transfer *xfer,
> +                                          void *context);
> +
> +extern void spi_message_dump_custom(struct spi_device *spi,
> +                                   struct spi_message *msg,
> +                                   size_t dump_head, size_t dump_tail,
> +                                   spi_transfer_dump_custom_t custom,
> +                                   void *context);
> +
> +static inline void spi_message_dump(struct spi_device *spi,
> +                                   struct spi_message *msg,
> +                                   size_t dump_head, size_t dump_tail)
> +{
> +       spi_message_dump_custom(spi, msg, dump_head, dump_tail, NULL, NULL);
> +}
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
