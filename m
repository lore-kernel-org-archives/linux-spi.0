From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH v2 12/12] wip: convert struct spi_device to gpio_desc
Date: Fri, 24 Nov 2017 14:03:19 +0100
Message-ID: <CAMuHMdWLw_jicndWQYcVkxKztW4rappPb+F58MXO+ykTTKpSpQ@mail.gmail.com>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz> <20170727220322.26654-13-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-13-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Chris,

On Fri, Jul 28, 2017 at 12:03 AM, Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> ---
>  drivers/spi/spi-ath79.c       | 26 +++-----------------------
>  drivers/spi/spi-atmel.c       |  4 ++--
>  drivers/spi/spi-bcm2835.c     |  8 ++++----
>  drivers/spi/spi-cadence.c     | 29 ++---------------------------
>  drivers/spi/spi-clps711x.c    | 13 +------------
>  drivers/spi/spi-davinci.c     | 10 ++++------
>  drivers/spi/spi-dw.c          |  7 -------
>  drivers/spi/spi-fsl-spi.c     | 29 +++++------------------------
>  drivers/spi/spi-img-spfi.c    | 25 +------------------------
>  drivers/spi/spi-lantiq-ssc.c  |  2 +-
>  drivers/spi/spi-mpc512x-psc.c | 20 +++-----------------
>  drivers/spi/spi-mt65xx.c      |  3 ---
>  drivers/spi/spi-omap2-mcspi.c | 17 ++---------------
>  drivers/spi/spi-orion.c       |  2 +-
>  drivers/spi/spi-pic32.c       | 11 +----------
>  drivers/spi/spi-s3c64xx.c     | 16 ++--------------
>  drivers/spi/spi-st-ssc4.c     | 29 +----------------------------
>  drivers/spi/spi.c             | 10 +++-------
>  include/linux/spi/spi.h       |  2 +-
>  19 files changed, 37 insertions(+), 226 deletions(-)

JFTR, this missed spi-sh-msiof (because it doesn't use gpio_is_valid()?).
And of course several recently introduced drivers.

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
