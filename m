From: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: (re)license code to the GPL v2
Date: Fri, 30 Dec 2016 10:16:15 +0530
Message-ID: <CAK-LDbKEAxNCAcUsN7UabdPcbKxCw_ewEjN4smLMvKhL2V+kGg@mail.gmail.com>
References: <20161229191313.21577-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
        Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
        Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
        Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161229191313.21577-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 30, 2016 at 12:43 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>
> My intention was to release this code under GPL v2 license. For some
> reason my initial commit 0fc6a323e191 ("spi: bcm53xx: driver for SPI
> controller on Broadcom bcma SoC") totally missed licensing info.
> MODULE_LICENSE was later added by Axel specifying "GNU Public License
> v2 or later".
>
> This patch clarifies situation by adding a proper header (with Copyright
> line) and adjusting MODULE_LICENSE. It should be acked by every driver
> contributor.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> ---
> Guys, can I have your Acked-by for this patch, please?

I am no longer using this mail address for the kernel contribution, so
adding acked by with the new mail address.

Thanks.

> Vaishali: you are author of commit 6774eea6d7a6 ("spi: bcm53xx: Adjust
> devm usage")

Acked-by: Vaishali Thakkar <vaishali.thakkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

> Joe: you are author of commit f7219b527b57 ("treewide: Remove
> unnecessary BCMA_CORETABLE_END macro")
>
> Nicholas: you are author of commit b3e7766bc459 ("spi: bcm53xx: use
> msecs_to_jiffies for conversion")
>
> Axel: you are author of commit 61d38b9a823c ("spi: bcm53xx: Add missing
> module information")
>
> Jingoo: you are author of commit 050429a78b2d ("spi: bcm53xx: make local
> symbol static")
> ---
>  drivers/spi/spi-bcm53xx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
> index 0c61ad4..6e409ea 100644
> --- a/drivers/spi/spi-bcm53xx.c
> +++ b/drivers/spi/spi-bcm53xx.c
> @@ -1,3 +1,11 @@
> +/*
> + * Copyright (C) 2014-2016 Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
>  #define pr_fmt(fmt)            KBUILD_MODNAME ": " fmt
>
>  #include <linux/kernel.h>
> @@ -355,4 +363,4 @@ module_exit(bcm53xxspi_module_exit);
>
>  MODULE_DESCRIPTION("Broadcom BCM53xx SPI Controller driver");
>  MODULE_AUTHOR("Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
> --
> 2.10.1
>



--=20
Vaishali
http://vaishalithakkar.in/
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
