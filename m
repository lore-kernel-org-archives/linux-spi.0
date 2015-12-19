From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: loopback-test: make dump_messages module
 parameter a bitmask
Date: Sat, 19 Dec 2015 03:43:40 +0200
Message-ID: <CAHp75VdEm0iyOxfWmM8E-uU0cekGras71D03VT1P5WKXdEAG4g@mail.gmail.com>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
	<1450442668-2391-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450442668-2391-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 18, 2015 at 2:44 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Make dump_messages module parameter a bitmask to allow for better
> granularity when dumping messages.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/spi/spi-loopback-test.c |   40 ++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
> index 8dac6a4..6e76c3e 100644
> --- a/drivers/spi/spi-loopback-test.c
> +++ b/drivers/spi/spi-loopback-test.c
> @@ -36,11 +36,17 @@ MODULE_PARM_DESC(simulate_only, "if not 0 do not execute the spi message");
>
>  /* dump spi messages */
>  int dump_messages;
> +#define DUMP_MESSAGE_AFTER             BIT(0)
> +#define DUMP_MESSAGE_BEFORE            BIT(1)
> +#define DUMP_MESSAGE_DATA_AFTER                BIT(2)
> +#define DUMP_MESSAGE_DATA_BEFORE       BIT(3)

DUMP is used in lib/hexdump.c, I would suggest
SPI_DUMP_MSG_

>  module_param(dump_messages, int, 0);
> -MODULE_PARM_DESC(dump_message,
> -                "=1 dump the basic spi_message_structure, " \
> -                "=2 dump the spi_message_structure including data, " \
> -                "=3 dump the spi_message structure before and after execution");
> +MODULE_PARM_DESC(dump_messages,
> +                "BIT(0) - dump the basic spi_message_structure after processing, "
> +                "BIT(1) - dump the basic spi_message_structure before processing, "
> +                "BIT(2) - also dump the spi_message data after processing, "
> +                "BIT(3) - also dump the spi_message data before processing");

Logically it is exactly two bits, not four.

> +
>  /* the device is jumpered for loopback - enabling some rx_buf tests */
>  int loopback;
>  module_param(loopback, int, 0);
> @@ -749,9 +755,15 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
>
>         /* only if we do not simulate */
>         if (!simulate_only) {
> -               /* dump the complete message before and after the transfer */
> -               if (dump_messages == 3)
> -                       spi_message_dump_data(spi, msg, 1024);
> +               /* dump the complete message before the transfer */
> +               if (dump_messages & DUMP_MESSAGE_BEFORE) {
> +                       /* calc bytes to dump */

> +                       if (dump_messages & DUMP_MESSAGE_DATA_BEFORE)
> +                               i = 1024;
> +                       else
> +                               i = 0;

Ternary operator ?

> +                       spi_message_dump_data(spi, msg, i);
> +               }
>
>                 /* run spi message */
>                 ret = spi_sync(spi, msg);
> @@ -786,10 +798,16 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
>
>         /* if requested or on error dump message (including data) */
>  exit:
> -       if (dump_messages || ret)
> -               spi_message_dump_data(spi, msg,
> -                                     ((dump_messages >= 2) || (ret)) ?
> -                                     1024 : 0);
> +       if ((dump_messages & DUMP_MESSAGE_AFTER) || ret) {
> +               /* calc bytes to dump */

> +               i = 0;
> +               if (dump_messages & DUMP_MESSAGE_DATA_AFTER)
> +                       i = 1024;
> +               if (ret)
> +                       i = 1024;

Ditto.

i = (dump_messages & DUMP_MESSAGE_DATA_AFTER) || ret ? 1024 : 0;

> +               /* dump the message */
> +               spi_message_dump_data(spi, msg, i);
> +       }
>
>         return ret;
>  }
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
