From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/4] Cleaned hexadecimal dump
Date: Mon, 9 Mar 2015 14:51:17 +0100
Message-ID: <CAMuHMdU4JeKqH7ac2iC0EkWYdH+3-xNmKyeVBq374gcmdCQ9GQ@mail.gmail.com>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
	<1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425750995-18176-2-git-send-email-adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Mar 7, 2015 at 6:56 PM, Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
> index 3a2f9d59edab..533050ced9f1 100644
> --- a/Documentation/spi/spidev_test.c
> +++ b/Documentation/spi/spidev_test.c
> @@ -15,6 +15,7 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <getopt.h>
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
> @@ -35,6 +36,33 @@ static uint8_t bits = 8;
>  static uint32_t speed = 500000;
>  static uint16_t delay;
>
> +static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
> +{
> +       int i = 0;
> +       char *address = (char *)src;

If you use "const char *address", you don't need the cast.
If you use "const unsigned char *address", one more cast below can be dropped.

> +       char *line = (char *)address;

"const unsigned char *line", and drop the cast.

> +       unsigned char c;
> +
> +       printf("%s | ", prefix);
> +       while (length-- > 0) {
> +               printf("%02X ", (unsigned char)*address++);

> @@ -76,12 +104,7 @@ static void transfer(int fd)
>         if (ret < 1)
>                 pabort("can't send spi message");
>
> -       for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {
> -               if (!(ret % 6))
> -                       puts("");
> -               printf("%.2X ", rx[ret]);
> -       }
> -       puts("");
> +       hexDump(rx, ARRAY_SIZE(tx), 32, "RX");

I know rx and tx have the same size, but please switch to "ARRAY_SIZE(RX)"
while at it.

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
