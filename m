From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: (re)license code to the GPL v2
Date: Thu, 29 Dec 2016 20:36:34 +0100
Message-ID: <086e2171-944b-8dee-3b87-abd0e422f637@milecki.pl>
References: <20161229191313.21577-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
        Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
        Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
        Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161229191313.21577-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sending using Jingoo's new address.

Jingoo: can I have your Acked-by as requested below, please?

On 12/29/2016 08:13 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
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
> Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> ---
> Guys, can I have your Acked-by for this patch, please?
>
> Vaishali: you are author of commit 6774eea6d7a6 ("spi: bcm53xx: Adjust
> devm usage")
>
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
> + * Copyright (C) 2014-2016 Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
>  #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
>
>  #include <linux/kernel.h>
> @@ -355,4 +363,4 @@ module_exit(bcm53xxspi_module_exit);
>
>  MODULE_DESCRIPTION("Broadcom BCM53xx SPI Controller driver");
>  MODULE_AUTHOR("Rafał Miłecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
