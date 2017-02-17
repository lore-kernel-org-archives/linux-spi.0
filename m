From: Miguel Ojeda <miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add possibility to define bits-per-word property.
Date: Fri, 17 Feb 2017 11:06:44 +0100
Message-ID: <CANiq72n2+osAdJfRiQwaWuqz2rM0EinhMzqnbDuiRNwFXBuzEg@mail.gmail.com>
References: <20170216133910.18278-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216133910.18278-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Adrian,

Please review the style to match the kernel's (and the rest of the
code in the file). See an example below and
https://github.com/torvalds/linux/blob/master/Documentation/process/coding-style.rst

(I have no idea regarding the functional changes on this patch, I just
noticed the email coming from CERN and therefore I replied :-)

Cheers,
Miguel

On Thu, Feb 16, 2017 at 2:39 PM, Adrian Fiergolski
<adrian.fiergolski-vJEk5272eHo@public.gmane.org> wrote:
>
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
>  drivers/spi/spi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0239b45..d2267e9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1549,6 +1549,17 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
>         }
>         spi->max_speed_hz = value;
>
> +       /* Device bits-per-word */
> +       if( ! of_property_read_u32(nc, "spi-bits-per-word", &value) ){

e.g.

 if (!of_property_read_u32(nc, "spi-bits-per-word", &value)) {

>
> +         if( value > 32 )
> +           dev_warn(&master->dev,
> +                    "bits-per-word %d not supported\n",
> +                    value);
> +         else
> +           spi->bits_per_word = value;
> +       }
> +
> +
>         /* Store a pointer to the node in the device structure */
>         of_node_get(nc);
>         spi->dev.of_node = nc;
> @@ -1626,6 +1637,13 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>
>                         spi->max_speed_hz = sb->connection_speed;
>
> +                       if(sb->data_bit_length > 32)
> +                                   dev_warn(&master->dev,
> +                                            "bits-per-word %d not supported\n",
> +                                            sb->data_bit_length);
> +                       else
> +                         spi->bits_per_word = sb->data_bit_length;
> +
>                         if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
>                                 spi->mode |= SPI_CPHA;
>                         if (sb->clock_polarity == ACPI_SPI_START_HIGH)
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
